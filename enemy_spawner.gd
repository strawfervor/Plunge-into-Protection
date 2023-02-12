extends Marker2D

var spawned_already = 0
var fireball = preload("res://smaller_nodes/fireball_orange.tscn")
var rat = preload("res://enemy_rat.tscn")
var scorpio = preload("res://enemies/enemy_scorpio.tscn")
var fly = preload("res://enemies/enemy_fly.tscn")
var enemies = [
	rat,
	scorpio,
	fly
	]

var enemies_list = [rat, rat, scorpio, fly] #list stores enemies to spawn from list
var enemies_list_index = 0
var enemies_random = false

var rng = RandomNumberGenerator.new()
var root #this varible is used to store node root scene

var speed_modificator = 0 #add speed to every enemy

var enemies_killed = 0
@export var max_enemies = 6

var level_finished = false

func _ready():
	root = get_parent()
	rng.randomize()
	if enemies_random == false:
		max_enemies = enemies_list.size()
	spawn_enemy()
	$FireballTimer.wait_time = rng.randf_range(8.5, 12.5)

func spawn_enemy(): #can be true, or index number
	#varible to hold enemy type
	var new_enemy
	#checking if enemy total is lower or equal max_enemies to not spawn too much enemies
	if spawned_already < max_enemies:
		#checking if need to give random enemy or specific one
		if enemies_random == true:
			var array_index = rng.randi_range(0, enemies.size() - 1)
			new_enemy = enemies[array_index].instantiate()
		elif enemies_random == false:
			new_enemy = enemies_list[enemies_list_index].instantiate()
			enemies_list_index +=1
		
		#checking what side of map should spawn enemy
		var spawn_position = Vector2(32,32)
		if spawned_already % 2 == 0:
			spawn_position = Vector2(48, 68)
		else:
			spawn_position = Vector2(458, 68)
		
		new_enemy.position = spawn_position
		new_enemy.SPEED += speed_modificator
		spawned_already += 1
		root.add_child.call_deferred(new_enemy)
		$SpawnTime.wait_time = rng.randf_range(1.5, 3.5)
		#print($SpawnTime.wait_time)
		$SpawnTime.start()

func _on_spawn_time_timeout():
	spawn_enemy()

#function doing somethin when enemy is killed (now it is only counting them, and calling detection for last one)
func enemy_killed():
	enemies_killed += 1
	#print("Spawned: ", spawned_already, " Killed: ", enemies_killed)
	last_enemy_detection()
	if (spawned_already == max_enemies) && ((spawned_already - enemies_killed) == 0):
		level_finished = true

#if last enemy - give it a speed boost
func last_enemy_detection():
	var last_enemies = get_tree().get_nodes_in_group("enemy")
	if enemies_killed == spawned_already - 1 && enemies_killed == max_enemies -1:
		for e in last_enemies:
			e.SPEED_up(50)     #change speed of enemy to +150
			e.modulate.r = 200 #change color of enemy to "reddish"


func _spawn_fireball_timeout():
	var player = get_parent().get_node("Player") #get player position for checking where to spawn enemy
	var fireball_spawn = Vector2(0, 0) #vector2 for holdiing new position for fireball
	var new_fireball
	if player.position.y > 224:
		fireball_spawn.y = 256
	elif player.position.y > 160:
		fireball_spawn.y = 192
	elif player.position.y > 96:
		fireball_spawn.y = 128
	else:
		fireball_spawn.y = 32
	
	if player.position.x < 255:
		fireball_spawn.x = 512
	else:
		fireball_spawn.x = 1
	
	new_fireball = fireball.instantiate()
	new_fireball.position = fireball_spawn
	root.add_child.call_deferred(new_fireball)
