extends CharacterBody2D

const SPEED = 100

@onready var organe := get_tree().get_current_scene().get_node("Organe") as TileMapLayer
@onready var pipes := get_tree().get_current_scene().get_node("Posage") as TileMapLayer
@onready var level := get_tree().get_current_scene().get_node("Level") as TileMapLayer

@onready var start_pos = position

var check = false
var checkpoint = 0
var checkpoint_names = ["poumons", "coeur", "cerveau","end"]

func _physics_process(delta: float) -> void:
	
	if (Input.is_action_just_pressed("ui_down")):
		check = true
	
	if check:
		var res = check_path(delta)
		match res:
			"true":
				check = false
				print("winner")
			"false":
				check = false
				$fail.show()
				await get_tree().create_timer(2.0).timeout
				get_tree().change_scene_to_file("res://Main.tscn")
				print("looser")
			_:
				pass
				#print("computing") 
			
func check_path(delta) -> String:
	
	var is_connected = check_connection()
	
	
	var dir = to_local($NavigationAgent2D.get_next_path_position()).normalized()
	velocity = dir * SPEED * delta
	#move_and_slide()
	position += velocity
	
	var organ_name = get_tile(organe)
	var pipe_name = get_tile(pipes)
	var level_name = get_tile(level)
	#print("name: ", name, "checkpoint: ", checkpoint_names[checkpoint])
	
	print(organ_name)
	if organ_name == checkpoint_names[checkpoint]:
		checkpoint += 1
		
	var color_check = true
	if (pipe_name == "bleu" or level_name == "bleu") and checkpoint > 0:
		color_check = false
	if (pipe_name == "red" or level_name == "red") and checkpoint == 0:
		color_check = false

	if not color_check:
		return "false"
	if not $NavigationAgent2D.is_navigation_finished():
		return "computing"
	if is_connected and checkpoint == 3:
		position = start_pos
		return "true"
	else:
		position = start_pos
		return "false"
		
func check_connection() -> bool:
	
	$NavigationAgent2D.target_position = Vector2i((4*32)+48,0)
	var res = $NavigationAgent2D.is_target_reachable()
	
	return res

func get_tile(tilemap: TileMapLayer) -> String:
	
	var pos = tilemap.local_to_map(position)
	var tile = tilemap.get_cell_tile_data(pos)
	
	
	var data = ""
	if tile != null:
		data = tile.get_custom_data("identifiant")
		print(data)
		
	return data
