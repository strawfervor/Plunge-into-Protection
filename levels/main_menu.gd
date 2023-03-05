extends Control

func _ready():
	$VBoxContainer/Start.grab_focus()
	$CreditsText.hide()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/classic_levels.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	$CreditsText.show()


func _on_random_pressed():
	get_tree().change_scene_to_file("res://levels/random_levels.tscn")


func _on_story_pressed():
	get_tree().change_scene_to_file("res://levels/story/intro/intro_story.tscn")
