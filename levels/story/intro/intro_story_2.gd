extends Node2D

var rat_dead = false
var dip_to_black = false
var dead_particles = preload("res://dead_particles.tscn")

func _process(delta):
	if $Phase.modulate.a > -0.1:
		$Phase.modulate.a -= 0.3 * delta
		print($Phase.modulate.a)
	if dip_to_black:
		$Blackness.modulate.a += 0.5 * delta

func _on_next_level_body_entered(body):
	if rat_dead:
		$nextLevelTimer.start()
		$Player.queue_free()
		var new_particles = dead_particles.instantiate()
		new_particles.position = $Player.position
		new_particles.position.y += 7
		add_child(new_particles)
		dip_to_black = true


func _on_next_level_timer_timeout():
	get_tree().change_scene_to_file("res://levels/easy_mode/easy_levels.tscn")
