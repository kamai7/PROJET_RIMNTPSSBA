extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var cpt = 0
var mod_red = Vector2i(0,2)
var red = false

func _input(event: InputEvent) -> void:
	
	var pos = to_local(get_global_mouse_position())
	var mouse_in_tile = local_to_map(pos)
	
	if Input.is_action_just_pressed("ui_left"):
		red = not red
		
	if Input.is_action_pressed("place"):
		
		var mod = Vector2i.ZERO
		if red:
			mod = mod_red
			
		if is_blocked(mouse_in_tile):
			pass
		elif get_cell_source_id(mouse_in_tile) != 0:
			
			if get_cell_source_id(mouse_in_tile - Vector2i(0,1)) == 0 and not is_blocked(mouse_in_tile - Vector2i(0,1)):
				set_cell(mouse_in_tile,0,Vector2i(0,0) + mod)
				if get_cell_source_id(mouse_in_tile - Vector2i(1,1)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,1),0,Vector2i(2,0) + mod)
				elif get_cell_source_id(mouse_in_tile - Vector2i(-1,1)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,1),0,Vector2i(1,0) + mod)
				elif get_cell_source_id(mouse_in_tile - Vector2i(0,2)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,1),0,Vector2i(0,0) + mod)
					
			elif get_cell_source_id(mouse_in_tile - Vector2i(0,-1)) == 0 and not is_blocked(mouse_in_tile - Vector2i(0,-1)):
				set_cell(mouse_in_tile,0,Vector2i(0,0) + mod)
				if get_cell_source_id(mouse_in_tile - Vector2i(1,-1)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,-1),0,Vector2i(2,1) + mod)
				elif get_cell_source_id(mouse_in_tile - Vector2i(-1,-1)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,-1),0,Vector2i(1,1) + mod)
				elif get_cell_source_id(mouse_in_tile - Vector2i(0,-2)) == 0:
					set_cell(mouse_in_tile - Vector2i(0,-1),0,Vector2i(0,0) + mod)
				
			elif get_cell_source_id(mouse_in_tile - Vector2i(1,0)) == 0 and not is_blocked(mouse_in_tile - Vector2i(1,0)):
				set_cell(mouse_in_tile,0,Vector2i(0,1) + mod)
				if get_cell_source_id(mouse_in_tile - Vector2i(1,1)) == 0:
					set_cell(mouse_in_tile - Vector2i(1,0),0,Vector2i(1,1) + mod)
				elif get_cell_source_id(mouse_in_tile - Vector2i(1,-1)) == 0:
					set_cell(mouse_in_tile - Vector2i(1,0),0,Vector2i(1,0) + mod)
				elif get_cell_source_id(mouse_in_tile - Vector2i(2,0)) == 0:
					set_cell(mouse_in_tile - Vector2i(1,0),0,Vector2i(0,1) + mod)
				
				
			elif get_cell_source_id(mouse_in_tile - Vector2i(-1,0)) == 0 and not is_blocked(mouse_in_tile - Vector2i(-1,0)):
				set_cell(mouse_in_tile,0,Vector2i(0,1)  + mod)
				if get_cell_source_id(mouse_in_tile - Vector2i(-1,1)) == 0:
					set_cell(mouse_in_tile - Vector2i(-1,0),0,Vector2i(2,1) + mod)
				elif get_cell_source_id(mouse_in_tile - Vector2i(-1,-1)) == 0:
					set_cell(mouse_in_tile - Vector2i(-1,0),0,Vector2i(2,0) + mod)
				elif get_cell_source_id(mouse_in_tile - Vector2i(-2,0)) == 0:
					set_cell(mouse_in_tile - Vector2i(-1,0),0,Vector2i(0,1) + mod)
				
			else:
				set_cell(mouse_in_tile,0,Vector2i(0,0) + mod)
				#:3
		
		else:
			var pipes = [Vector2i(0,0) + mod,Vector2i(0,1) + mod,Vector2i(1,0) + mod,Vector2i(2,0) + mod,Vector2i(1,1) + mod,Vector2i(2,1) + mod]
			if cpt < len(pipes) - 1:
				cpt +=1
			else:
				cpt = 0
			set_cell(mouse_in_tile,0,pipes[cpt])
	
	if Input.is_action_pressed("delete") and not is_blocked(mouse_in_tile):
		erase_cell(mouse_in_tile)
		
func is_blocked(pos: Vector2i) -> bool:
	
	var try = false
	if get_cell_tile_data(pos) != null:
		try = true
	
	if try and get_cell_tile_data(pos).get_custom_data("identifiant") == "bloque":
		return true
	else:
		return false
	
