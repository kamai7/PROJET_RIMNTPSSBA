extends CharacterBody2D

const SPEED = 300

func _physics_process(delta: float) -> void:
	check_path()
	
	var dir = to_local($NavigationAgent2D.get_next_path_position())
	velocity = dir * SPEED * delta
	
	move_and_slide()

func check_path():
	
	$NavigationAgent2D.target_position = Vector2i(3*32,0)
	var res = $NavigationAgent2D.is_target_reachable()
	print(res)
	
	
