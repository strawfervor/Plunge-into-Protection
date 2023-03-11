extends Node2D

var level_classic_1 = preload("res://levels/classic_level_1_blue.tscn")
var level_classic_2 = preload("res://levels/classic_level_2_orange_short.tscn")
var level_classic_3 = preload("res://levels/classic_level_3_gemlike_purple.tscn")
var level_game_over = preload("res://levels/game_over.tscn")
var level_classic_4 = preload("res://test_scene.tscn")
var level_random_1 = preload("res://levels/level_random_1.tscn")
var next_level
var current_level
var rat = preload("res://enemy_rat.tscn")
var scorpio = preload("res://enemies/enemy_scorpio.tscn")
var fly = preload("res://enemies/enemy_fly.tscn")
var levels_array = [
	[rat, rat, rat],
	[rat, rat, rat, rat, rat],
	[scorpio, scorpio, scorpio, scorpio],
	[scorpio, scorpio, scorpio, scorpio, rat, rat],
	[fly, fly, fly, fly],
	[fly, fly, scorpio, scorpio, fly],
	[rat, rat, rat, rat, fly, scorpio, fly],
	[scorpio, scorpio, scorpio, scorpio, fly, fly, rat],
	[scorpio, scorpio, fly, scorpio, fly,  scorpio, fly, fly, rat]
]

var root

var level_loaded = false
var spawner

var points = 0

var pow_block_status = 3

signal next_level_please

func _process(delta):
	if level_loaded:
		if spawner.level_finished:
			on_finished_level()

func _ready():
	root = get_parent()
	load_level(0, 0, 1)
	stats_update()

func load_level(level_number, speed_modificator, level_type):
	match level_type:
		1:
			next_level = level_classic_1
		2:
			next_level = level_classic_2
		3:
			next_level = level_classic_3
		4:
			next_level = level_classic_4
		"random":
			next_level = level_random_1
	
	current_level = next_level.instantiate()
	set_level(level_number, speed_modificator)
	level_loaded = true
	add_child(current_level)
	current_level.get_node("Player").im_dead.connect(_player_dead)

func stats_update():
	print("stats update")

func set_level(number, speed):
	spawner = current_level.get_node("EnemySpawner")
	spawner.enemies_random = false #true gereting random enemies, false generete enemies from list, one by one
	spawner.max_enemies = 1
	spawner.enemies_list = levels_array[number] #list of enemies to spawn (rat, scorpio, fly)
	spawner.speed_modificator = speed
	spawner.add_points.connect(_add_points)
	current_level.get_node("POW_block").hitted_pow_block.connect(_hitted_pow_block)
	current_level.get_node("POW_block").status = pow_block_status

func on_finished_level():
	level_loaded = false
	remove_child(current_level)
	next_level_please.emit()

func _add_points():
	root.update_score()
	
func _hitted_pow_block():
	pow_block_status -= 1

func _player_dead():
	root.live_lost()

func on_game_over():
	remove_child(current_level)
	current_level = level_game_over.instantiate()
	add_child(current_level)
