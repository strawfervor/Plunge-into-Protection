extends Node2D

var zooming = Vector2(1, 1)

func _unhandled_input(event):
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene_to_file("res://levels/story/intro/intro_story_2.tscn")

func _process(delta):
	$CameraBody/Phase.modulate.a -= 0.3 * delta
	if $CameraBody.position.x  > 258:
		$CameraBody.position.x -= 2
	if $CameraBody.position.x  <= 258:
		if $CameraBody.position.y != 112:
			$CameraBody.position.y -= 2
		if zooming.x < 4.2:
			zooming.x += 0.1
			zooming.y += 0.1
			$CameraBody/Camera2D.set_zoom(zooming)
		if zooming.x >= 4.2:
			if $Timer_next_scene.is_stopped():
				$Timer_next_scene.start()


func _on_timer_next_scene_timeout():
	get_tree().change_scene_to_file("res://levels/story/intro/intro_story_2.tscn")
