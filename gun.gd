extends Area2D

func _physics_process(delta):
	
	#retrives the mob nodes that are overlapping with the collision area
	# and reterns them as an array
	var enemies_in_range = get_overlapping_bodies()
	
	# setting the target for the gun to shoot at and damage
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		
		#look at the position of the enemy being targeted
		look_at(target_enemy.global_position)

#function for shooting bullets
func shoot():
	
	# load the bullets
	#load function loads the file on demand, whereas preload loads the file at the start of the program
	const BULLET = preload("res://bullet.tscn")
	
	# creating a new bullet scene instance
	var new_bullet = BULLET.instantiate()
	
	# move the new bullet to the shooting point
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation 
	
	#adding the new bullet as a child of the shooting point
	%ShootingPoint.add_child(new_bullet)
	

func _on_timer_timeout() -> void:
	shoot()
