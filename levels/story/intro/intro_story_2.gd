extends Node2D

func _on_next_level_body_entered(body):
	$nextLevelTimer.start()
	$Player.queue_free()


func _on_next_level_timer_timeout():
	get_tree().change_scene_to_file("res://levels/classic_levels.tscn")
