extends Control

func _ready():
	$VBoxContainer/Start.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/classic_levels.tscn")


func _on_exit_pressed():
	get_tree().quit()
