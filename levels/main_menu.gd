extends Control

func _ready():
	$VBoxContainer/Story.grab_focus()
	$CreditsText.text = "Designed for novice players or those who prefer a more laid-back gaming experience"

func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/classic_levels.tscn")


func _on_exit_pressed():
	get_tree().quit()

func _on_random_pressed():
	get_tree().change_scene_to_file("res://levels/random_levels.tscn")


func _on_story_pressed():
	get_tree().change_scene_to_file("res://levels/story/intro/intro_story.tscn")

func _unhandled_input(event):
	if $VBoxContainer/Story.has_focus():
		$CreditsText.text = "Designed for novice players or those who prefer a more laid-back gaming experience"
	if $VBoxContainer/Start.has_focus():
		$CreditsText.text = "This is how the game should be played"
	if $VBoxContainer/Random.has_focus():
		$CreditsText.text = "Defeat growing waves of random enemies"
	if $VBoxContainer/Credits.has_focus():
		$CreditsText.text = "Graphics inspired by retro lines (vexed)\n\nSound: SubspaceAudio @ OpenGameART.org\n\nMusic: Nario Versus Zonik by Ragnar Random"
	if $VBoxContainer/Exit.has_focus():
		$CreditsText.text = " "
