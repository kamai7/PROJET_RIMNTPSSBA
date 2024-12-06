extends Node2D

var check = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Background.generate_bg(6, 5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_enter")):
		check = true
	
	if check:
		var res = $CharacterBody2D.check_path(delta)
		match res:
			"true":
				check = false
				res = false
				get_tree().change_scene_to_file("res://Scenes/levels/win.tscn")
				print("winner")
			"false":
				check = false
				res = true
				get_tree().change_scene_to_file("res://Scenes/levels/Level5.tscn")
				print("looser")
			_:
				pass
