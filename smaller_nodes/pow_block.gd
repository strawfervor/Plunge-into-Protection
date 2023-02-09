extends AnimatableBody2D

func _ready():
	$AnimatedSprite2D.animation = "full"

func _on_collision_detect_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		print("player hitter")
		hit_all_bricks()
		if $AnimatedSprite2D.animation == "full":
			$AnimatedSprite2D.animation = "half"
		elif $AnimatedSprite2D.animation == "half":
			$AnimatedSprite2D.animation = "quarter"
		elif $AnimatedSprite2D.animation == "quarter":
			queue_free()

func hit_all_bricks():
	var all_bricks = get_tree().get_nodes_in_group("brick")
	
	for brick in all_bricks:
		brick.hitted_pow_block()
