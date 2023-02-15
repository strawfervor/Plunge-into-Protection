extends Control

func _process(delta):
	if (Input.is_action_just_released("ui_accept")):
		get_tree().change_scene_to_file("res://levels/main_menu.tscn")
