extends CharacterBody2D

@export var speed = 150
@export var jump_speed = -320
@export var gravity = 700
@export var friction = 0.1
@export var acceleration = 0.2
var is_moving = false
signal jumping
var respawn_platform = preload("res://respawn_platform.tscn")
signal im_dead

func _physics_process(delta):
	#old movment in now in function:
	#old_movement(delta)
	movement_friction(delta)
	
	#if on ground - can jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		$JumpSound.play()
		emit_signal("jumping")

	#change animation if player on ground
	if is_on_floor() && is_moving == true:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
	elif !is_on_floor(): #change animation to jumping if player is not on the floor
		$AnimatedSprite2D.animation = "jump"
	elif is_moving == false:
		$AnimatedSprite2D.animation = "idle"
	
	#two if statements for moving character from one side to otherone
	if position.x < -6:
		position.x = 516
	#player leave on right - position is swapped to left
	if position.x > 516:
		position.x = -1
	
	##dead if fall down
	if position.y > 310:
		dead()

func dead():
	im_dead.emit()
	$DeadSound.play()
	var new_resp_platform = respawn_platform.instantiate()
	new_resp_platform.position = Vector2(255, 40)
	add_sibling(new_resp_platform)
	position.x = 255
	position.y = 32
	velocity = Vector2(0,0)
	speed = 0
	jump_speed = 0
	$AnimatedSprite2D.modulate.a = 0.3
	$AfterDeadTimer.start()

func old_movement(delta):
		#gravity add to player y
	velocity.y += gravity * delta
	
	#move left/right
	velocity.x = Input.get_axis("left", "right") * speed
	#velocity.x = lerp(velocity.x, 0, friction)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0

	move_and_slide()

func movement_friction(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
		$AnimatedSprite2D.flip_h = velocity.x < 0
		is_moving = true
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		is_moving = false
	move_and_slide()




func _on_collision_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("enemy") && body.hitted == false:
		dead()


func _on_after_dead_timer_timeout():
	$AnimatedSprite2D.modulate.a = 1
	speed = 150
	jump_speed = -320
