extends Marker2D

var spawned_already = 0
var rat = preload("res://enemy_rat.tscn")
var enemies = [
	rat
	]

var rng = RandomNumberGenerator.new()
var root #this varible is used to store node root scene

var enemies_killed = 0
@export var max_enemies = 4

func _ready():
	root = get_parent()
	rng.randomize()
	spawn_enemy(true)

func spawn_enemy(random): #can be true, or index number
	#varible to hold enemy type
	var new_enemy
	#checking if enemy total is lower or equal max_enemies to not spawn too much enemies
	if spawned_already - enemies_killed < max_enemies:
		#checking if need to give random enemy or specific one
		if random:
			var array_index = rng.randi_range(0, enemies.size() - 1)
			new_enemy = enemies[array_index].instantiate()
		else:
			new_enemy = enemies[random].instantiate()
		
		#checking what side of map should spawn enemy
		var spawn_position = Vector2(32,32)
		if spawned_already % 2 == 0:
			spawn_position = Vector2(48, 62)
		else:
			spawn_position = Vector2(458, 62)
		
		new_enemy.position = spawn_position
		spawned_already += 1
		root.add_child.call_deferred(new_enemy)
		$SpawnTime.wait_time = rng.randf_range(1.5, 3.5)
		print($SpawnTime.wait_time)
		$SpawnTime.start()

func _on_spawn_time_timeout():
	spawn_enemy(true)

func enemy_killed():
	enemies_killed += 1
	print("Spawned: ", spawned_already, "Killed: ", enemies_killed)
