extends Node2D

var zooming = Vector2(1, 1)

func _process(delta):
	if $CameraBody.position.x  > 258:
		$CameraBody.position.x -= 2
	if $CameraBody.position.x  <= 258:
		if $CameraBody.position.y != 112:
			$CameraBody.position.y -= 2
		if zooming.x < 4.2:
			zooming.x += 0.1
			zooming.y += 0.1
			$CameraBody/Camera2D.set_zoom(zooming)
