extends Node2D

var level_number = 1
var player_lives = 3
var score = 0
var enemies_left = 0
var points = 0
var level_type = 1
var game_over = false

func _ready():
	$UI/Phase.text = "LEVEL " + str(level_number)
	$UI/Phase.show()
	$UI/Points.text = "SCORE: " + str(points)
	$UI/Points.show()
	$UI/Lives.hide()


func _on_phase_show_timeout():
	$UI/Phase.hide()

func _next_level():
	$NextLevelTimer.start()
	level_number += 1
	$UI/Phase.text = "LEVEL " + str(level_number)
	$UI/Phase.show()
	$UI/PhaseShow.start()
	
func update_score():
	points += 100 + (level_number * 10)
	$UI/Points.text = "SCORE: " + str(points)
	$UI/Points.show()

func live_lost():
	points -= 200
	$UI/Points.text = "SCORE: " + str(points)
	$UI/Points.show()


func _on_next_level_timer_timeout():
	pass
