extends Node2D

var level_number = 1
var player_lives = 3
var score = 0
var enemies_left = 0
var level

func _ready():
	$UI/Phase.text = "PHASE " + str(level_number)
	$UI/Phase.show()
	level = get_node("Level")
	level.next_level_please.connect(_next_level)


func _on_phase_show_timeout():
	$UI/Phase.hide()

func _next_level():
	level_number += 1
	$UI/Phase.text = "PHASE " + str(level_number)
	$UI/Phase.show()
	$UI/PhaseShow.start()
	var cur_level = level_number % 9
	if (cur_level) > 0:
		level.load_level((cur_level - 1), level_number)
	else:
		level.load_level(9, level_number)
