extends CharacterBody2D

const SPEED = 5000

@onready var organe := get_tree().get_current_scene().get_node("Organe") as TileMapLayer

var checkpoint = 0
var checkpoint_names = ["poumons", "coeur", "cerveau","end"]

func _physics_process(delta: float) -> void:
	if check_path(delta):
		print("win")
	else:
		print("try again")

func check_path(delta) -> bool:
	
	var is_connected = check_connection()
	
	var dir = to_local($NavigationAgent2D.get_next_path_position()).normalized()
	velocity = dir * SPEED * delta
	move_and_slide()
	
	var name = get_tile(organe)
	#print("name: ", name, "checkpoint: ", checkpoint_names[checkpoint])
	
	if name == checkpoint_names[checkpoint]:
		checkpoint += 1
	
	if is_connected and checkpoint == 3:
		return true
	else:
		return false
		
func check_connection() -> bool:
	
	$NavigationAgent2D.target_position = Vector2i(3*32,0)
	var res = $NavigationAgent2D.is_target_reachable()
	
	return res

func get_tile(tilemap: TileMapLayer) -> String:
	
	var pos = Vector2i(int(position.x / 32), int(position.y / 32))
	var tile = tilemap.get_cell_tile_data(pos)
	
	var data = ""
	if tile != null:
		data = tile.get_custom_data("identifiant")
	
	return data
