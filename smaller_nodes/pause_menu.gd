extends Control

var paused = false
var mute = false

func _ready():
	if mute == false:
		$VBoxContainer/mute.text = "mute"
	else:
		$VBoxContainer/mute.text = "unmute"
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


func _on_mute_pressed():
	Input.action_press("mute")
	if mute == true:
		$VBoxContainer/mute.text = "mute"
		mute = false
	else:
		$VBoxContainer/mute.text = "unmute"
		mute = true
