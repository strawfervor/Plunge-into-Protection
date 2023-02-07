extends CharacterBody2D


var SPEED = 100.0
var speed_restore = SPEED
const JUMP_VELOCITY = -400.0
var direction_set = 0
var hitted = false
var to_delete = false
var times_flipped = 0
var gravity = 2000

func _ready():
	#directory depends on spawned position
	if position.x < 256:
		direction_set = 1
	else:
		direction_set = -1


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = direction_set
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "default"
		$AnimatedSprite2D.flip_h = velocity.x > 0
		$AnimatedSprite2D.play()

	move_and_slide()
	
	#two if statements for moving character from one side to otherone
	if position.x < -6 and position.y < 250:
		position.x = 516
	elif position.x < -6:
		position = Vector2(516, 60)
	#player leave on right - position is swapped to left
	if position.x > 516 and position.y < 250:
		position.x = -1
	elif position.x > 516:
		position = Vector2(-1, 60)



func _on_change_dir_detect_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body != self:
		direction_set = direction_set * (-1)

#when enemy is hitted by floor
func hit():
	if hitted == false:
		times_flipped += 1
		hitted = true #flag hitted on
		speed_restore = SPEED
		SPEED = 0 #stop from moving
		$AnimatedSprite2D.flip_v = true #put enemy on backs
		$HittedTimer.start() #start counting (4 sec, default)
		$AnimatedSprite2D.offset.y = 7 #set offset, becouse just flipping will make enemy hovers over ground when on backs

#when timer started in func hit() is zero:
func _on_hitted_timer_timeout():
	if to_delete == false:
		$AnimatedSprite2D.flip_v = false #go back on legs dear enemy
		if times_flipped < 5:
			SPEED = speed_restore + 20 #set speed back to default speed
		else:
			SPEED = speed_restore
		hitted = false #hitted flag off
		$AnimatedSprite2D.offset.y = 0 #set back offset to default

#when something (player) collided with bigger "killing" detector
func _on_killing_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if hitted == true && body.is_in_group("player"): #checking if enemy is on backs and if body is player
		$DeadParticles.emitting = true #start emmiting particles
		$AnimatedSprite2D.hide() #hide sprite
		to_delete = true #mark as to delete
		$DeleteItsDead.start() #start DeleteItsDead timer, when its timeout func below is starting

#when DeleteItsDead timer runout, enemy is deleted
func _on_delete_its_dead_timeout():
	if to_delete == true && $DeadParticles.emitting == false:
		print("deleted!")
		var spawner = get_parent().get_node("EnemySpawner")
		spawner.enemy_killed()
		queue_free()
