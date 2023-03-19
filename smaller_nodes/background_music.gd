extends Node

var mute = false
var volume

func _ready():
	if mute == false:
		$AudioStreamPlayer2D.play()


func _on_audio_stream_player_2d_finished():
	if mute == false:
		$AudioStreamPlayer2D.play()

func toggle_mute():
	if mute == false:
		mute = true
		AudioServer.set_bus_volume_db(0, -72)
	else:
		mute = false
		AudioServer.set_bus_volume_db(0, 0)

func _unhandled_input(event):
	if Input.is_action_just_pressed("mute"):
		toggle_mute()
