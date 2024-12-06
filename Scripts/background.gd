extends Node2D

var grid

const FIELD_TOP = 2
const FIELD_MIDDLE = 3
const FIELD_BOTTOM = 4

const FIELD_LEFT = 1
const FIELD_CENTER = 2
const FIELD_RIGHT = 3


func generate_bg(width: int, height: int):
	print("feur")
	for x in range(width):
		var rand1 = randi_range(1, 3)
		var rand2 = randi_range(1, 3)
		grid.set_cell(Vector2i(x, 0), 0, Vector2i(rand1, 0))
		grid.set_cell(Vector2i(x, 1), 0, Vector2i(rand2, 1))
	
	for x in range(width):
		for y in range(height):
			var coord = Vector2i.ZERO
			
			if (x == 0):
				coord.x = FIELD_LEFT
			elif (x == width-1):
				coord.x = FIELD_RIGHT
			else:
				coord.x = FIELD_CENTER
			
			if (y == 0):
				coord.y = FIELD_TOP
			elif (y == height-1):
				coord.y = FIELD_BOTTOM
			else:
				coord.y = FIELD_MIDDLE
			
			grid.set_cell(Vector2i(x, y+2), 0, coord)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("feuriste")
	grid = $TileMapLayer
	generate_bg(3, 5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
