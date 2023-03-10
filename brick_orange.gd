extends AnimatableBody2D

signal hitted
var overlaping #catching overlaping enemy

func _ready():
	$AnimatedSprite2D.animation = "default"

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$HitSound.play()
		emit_signal("hitted")
		$AnimatedSprite2D.animation = "hitted"
		$AnimatedSprite2D.play()

func _process(delta):
	if $AnimatedSprite2D.is_playing() && overlaping != null && overlaping.hitted == false:
		overlaping.hit() #calling enemy hit method

func _on_enemy_on_floor_body_entered(body):
	if body.is_in_group("enemy"):
		overlaping = body


func _on_enemy_on_floor_body_exited(body):
	overlaping = null

func hitted_pow_block():
	$AnimatedSprite2D.animation = "hitted"
	$AnimatedSprite2D.play()
