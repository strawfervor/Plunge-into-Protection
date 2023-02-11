extends CharacterBody2D

var gravity = 3500
var directory_y = 1
var directory_x = 0

func _ready():
	#directory depends on spawned position
	if position.x < 256:
		directory_x = 1
	else:
		directory_x = -1

func _process(delta):
	rotation_degrees += 10
	velocity.y = gravity * delta * directory_y
	velocity.x = gravity * delta * directory_x
	move_and_slide()
	#delete if out of scene:
	if position.x < -5:
		queue_free()
	elif position.x > 512:
		queue_free()
	elif position.y < 0:
		directory_y *= -1

#collision detections for fireball
func _on_detections_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("floor"): #bounce when on floor (change y direction)
		directory_y *= -1
	if body.is_in_group("player"): #if colides with player node, make him DEAD!
		var player = get_parent().get_node("Player")
		player.dead()
