extends CharacterBody2D

@export var speed = 150
@export var jump_speed = -320
@export var gravity = 700
signal jumping

func _physics_process(delta):
	#gravity add to player y
	velocity.y += gravity * delta
	
	#move left/right
	velocity.x = Input.get_axis("left", "right") * speed
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0

	move_and_slide()
	
	#if on ground - can jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		emit_signal("jumping")
	#change animation to jumping if player is not on the floor
	if !is_on_floor():
		$AnimatedSprite2D.animation = "jump"
	#change animation if player on ground
	if is_on_floor() and $AnimatedSprite2D.animation == "jump":
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
	
	#two if statements for moving character from one side to otherone
	if position.x < -6:
		position.x = 516
	#player leave on right - position is swapped to left
	if position.x > 516:
		position.x = -1
	
	#####dead
	if position.y > 310:
		dead()

func dead():
	position.x = 255
	position.y = 32


