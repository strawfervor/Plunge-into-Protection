extends AnimatableBody2D

var modulate_down = false

func _ready():
	modulate.a = 0.01

func _process(delta):
	if modulate_down == false && modulate.a < 0.9:
		modulate.a += 0.008
	elif modulate_down == false && modulate.a >= 0.9:
		modulate_down = true
	elif modulate_down:
		modulate.a -= 0.01
	
	if modulate.a < 0.1 && modulate_down:
		queue_free()
