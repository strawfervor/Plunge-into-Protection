extends AnimatableBody2D

var status = 3
signal hitted_pow_block

func _ready():
	if status == 3:
		$AnimatedSprite2D.animation = "full"
	if status == 2:
		$AnimatedSprite2D.animation = "half"
	if status == 1:
		$AnimatedSprite2D.animation = "quarter"
	if status == 0:
		queue_free()

func _on_collision_detect_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		hitted_pow_block.emit()
		hit_all_bricks()
		if $AnimatedSprite2D.animation == "full":
			$AnimatedSprite2D.animation = "half"
			status = 2
		elif $AnimatedSprite2D.animation == "half":
			$AnimatedSprite2D.animation = "quarter"
			status = 1
		elif $AnimatedSprite2D.animation == "quarter":
			queue_free()

func hit_all_bricks():
	var all_bricks = get_tree().get_nodes_in_group("brick")
	
	for brick in all_bricks:
		brick.hitted_pow_block()
