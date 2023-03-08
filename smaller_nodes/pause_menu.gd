extends Control

var paused = false

func _ready():
	$VBoxContainer/resume.grab_focus()
	self.visible = false

func pause():
	paused = true
	$VBoxContainer/resume.grab_focus()


func _on_resume_pressed():
	if self.visible == true && paused == true:
		self.visible = false
		paused = false
		get_tree().paused = false


func _on_quit_pressed():
	if self.visible == true && paused == true:
		get_tree().quit()
