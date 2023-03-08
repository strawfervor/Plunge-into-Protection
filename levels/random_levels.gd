extends Node2D

var level_number = 1
var player_lives = 3
var score = 0
var enemies_left = 0
var level
var points = 0
var level_type = 1
var game_over = false

func _ready():
	$UI/Phase.text = "PHASE " + str(level_number)
	$UI/Phase.show()
	$UI/Points.text = "SCORE: " + str(points)
	$UI/Points.show()
	level = get_node("Level")
	level.next_level_please.connect(_next_level)


func _on_phase_show_timeout():
	$UI/Phase.hide()

func _next_level():
	$NextLevelTimer.start()
	level_number += 1
	$UI/Phase.text = "PHASE " + str(level_number)
	$UI/Phase.show()
	$UI/PhaseShow.start()
	
func update_score():
	points += 100 + (level_number * 10)
	$UI/Points.text = "SCORE: " + str(points)
	$UI/Points.show()

func live_lost():
	if game_over == false:
		points -= 200
		player_lives -= 1
		$UI/Lives.text = "Lives: " + str(player_lives)
		$UI/Lives.show()
	
	if player_lives == 0 && game_over == false:
		game_over = true
		$UI/Lives.hide()
		$UI/Points.hide()
		level.on_game_over()


func _on_next_level_timer_timeout():
	var cur_level = level_number + 1
	level_type = "random"
	level.load_level(cur_level, level_number, level_type)

func _input(ev):
	if Input.is_action_just_pressed("pause"):
		$pause_menu.show()
		$pause_menu.pause()
		get_tree().paused = true
