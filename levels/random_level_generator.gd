extends Node2D

var rng = RandomNumberGenerator.new()

var brick_orange = preload("res://brick_orange.tscn")
var brick_black = preload("res://smaller_nodes/brick_black.tscn")
var brick_blue = preload("res://smaller_nodes/brick_blue.tscn")
var brick_green = preload("res://smaller_nodes/brick_green.tscn")
var brick_purple = preload("res://smaller_nodes/brick_purple.tscn")
var brick_white = preload("res://smaller_nodes/brick_white.tscn")

var bricks = [
	brick_orange,
	brick_black,
	brick_blue,
	brick_green,
	brick_purple,
	brick_white
]
func _ready():
	rng.randomize()
	var array_index = rng.randi_range(0, bricks.size() - 1)
	#array_index in funcion below is passing type of block with will be used to build level
	generate_row_long(222, array_index)
	generate_row_short(156, array_index)
	generate_row_long(88, array_index)

func generate_row_long(position_y, array_index):
	var numbers_array = []
	var exclude = rng.randi_range(4, 28)
	for i in range(1,33):
		if i != exclude && i != exclude + 1 && i != exclude + 2 && i != exclude + 3:
			numbers_array.append(i)
	
	for number in numbers_array:
		var new_platform
		new_platform = bricks[array_index].instantiate()
		new_platform.position = Vector2((number * 16 - 8), position_y)
		add_child.call_deferred(new_platform)

func generate_row_short(position_y, array_index):
	var numbers_array = []
	var first_blocks = rng.randi_range(1, 6)
	#print 2 short platforms, 4 pixel lower than  y
	print(first_blocks)
	for i in range(1,first_blocks + 1):
		var first_blocks_y = position_y + 4
		var new_platform
		new_platform = bricks[array_index].instantiate()
		new_platform.position = Vector2((i * 16 - 8), first_blocks_y)
		add_child.call_deferred(new_platform)
	
	#create last x blocks
	for i in range(33 - (8 - first_blocks),33):
		var first_blocks_y = position_y + 4
		var new_platform
		new_platform = bricks[array_index].instantiate()
		new_platform.position = Vector2((i * 16 - 8), first_blocks_y)
		add_child.call_deferred(new_platform)
	
	#create middle part
	for i in range(first_blocks + 5 ,(33 - (8 - first_blocks) - 4)):
		var first_blocks_y = position_y + 4
		var new_platform
		new_platform = bricks[array_index].instantiate()
		new_platform.position = Vector2((i * 16 - 8), first_blocks_y - 8)
		add_child.call_deferred(new_platform)
