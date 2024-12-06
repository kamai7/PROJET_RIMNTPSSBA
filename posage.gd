extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var cpt = 0
		
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("place"):
		var pos = get_global_mouse_position()
		var mouse_in_tile = local_to_map(pos)
		
		if get_cell_source_id(mouse_in_tile) != 0:
			if get_cell_source_id(mouse_in_tile - Vector2i(0,1)) == 0:
				set_cell(mouse_in_tile,0,Vector2i(0,0))
				if get_cell_source_id(mouse_in_tile - Vector2i(1,1)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,1),0,Vector2i(2,0))
				elif get_cell_source_id(mouse_in_tile - Vector2i(-1,1)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,1),0,Vector2i(1,0))
				elif get_cell_source_id(mouse_in_tile - Vector2i(0,2)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,1),0,Vector2i(0,0))
					
			elif get_cell_source_id(mouse_in_tile - Vector2i(0,-1)) == 0:
				set_cell(mouse_in_tile,0,Vector2i(0,0))
				if get_cell_source_id(mouse_in_tile - Vector2i(1,-1)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,-1),0,Vector2i(2,1))
				elif get_cell_source_id(mouse_in_tile - Vector2i(-1,-1)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,-1),0,Vector2i(1,1))
				elif get_cell_source_id(mouse_in_tile - Vector2i(0,-2)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,-1),0,Vector2i(0,0))
				
			elif get_cell_source_id(mouse_in_tile - Vector2i(1,0)) == 0:
				set_cell(mouse_in_tile,0,Vector2i(0,1))
				if get_cell_source_id(mouse_in_tile - Vector2i(1,1)) == 0:
					set_cell(mouse_in_tile - Vector2i(1,0),0,Vector2i(1,1))
				elif get_cell_source_id(mouse_in_tile - Vector2i(1,-1)) == 0:
					set_cell(mouse_in_tile - Vector2i(1,0),0,Vector2i(1,0))
				elif get_cell_source_id(mouse_in_tile - Vector2i(2,0)) == 0:
					set_cell(mouse_in_tile - Vector2i(1,0),0,Vector2i(0,1))
				
				
			elif get_cell_source_id(mouse_in_tile - Vector2i(-1,0)) == 0:
				set_cell(mouse_in_tile,0,Vector2i(0,1))
				if get_cell_source_id(mouse_in_tile - Vector2i(-1,1)) == 0:
					set_cell(mouse_in_tile - Vector2i(-1,0),0,Vector2i(2,1))
				elif get_cell_source_id(mouse_in_tile - Vector2i(-1,-1)) == 0:
					set_cell(mouse_in_tile - Vector2i(-1,0),0,Vector2i(2,0))
				elif get_cell_source_id(mouse_in_tile - Vector2i(-2,0)) == 0:
					set_cell(mouse_in_tile - Vector2i(-1,0),0,Vector2i(0,1))
				
			else:
				set_cell(mouse_in_tile,0,Vector2i(0,0))
		
		else:
			var pipes = [Vector2i(0,0),Vector2i(0,1),Vector2i(1,0),Vector2i(2,0),Vector2i(1,1),Vector2i(2,1)]
			if cpt < len(pipes) - 1:
				cpt +=1
			else:
				cpt = 0
			set_cell(mouse_in_tile,0,pipes[cpt])
	
	if Input.is_action_pressed("delete"):
		var pos = get_global_mouse_position()
		var mouse_in_tile = local_to_map(pos)
		erase_cell(mouse_in_tile)
