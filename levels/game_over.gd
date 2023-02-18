extends Control

var modulate_down = true
var unlocked = false

func _ready():
	$enter.position = Vector2(108, 129)

func _process(delta):
	if (Input.is_action_just_released("ui_accept")) && unlocked:
		get_tree().change_scene_to_file("res://levels/main_menu.tscn")
	
	if $enter.modulate.a > 0.0 && modulate_down == true:
		$enter.modulate.a -= 0.03
	elif $enter.modulate.a < 1.0 && modulate_down == false:
		$enter.modulate.a += 0.03
	elif $enter.modulate.a <= 0.0:
		modulate_down = false
	elif $enter.modulate.a >= 1.0:
		modulate_down = true



func _on_unlock_enter_timeout():
	unlocked = true
