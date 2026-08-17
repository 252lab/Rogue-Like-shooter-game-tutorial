extends Node2D

#function for creating mobs within the game world
func spawn_mobs():
	
	#creating a new mob
	var new_mob = preload("res://mob.tscn").instantiate()
	
	#generating a random start position
	%PathFollow2D.progress_ratio = randf()
	
	# moving the mob to that position
	new_mob.global_position = %PathFollow2D.global_position
	
	# adding mob to the tree to add it to the game
	add_child(new_mob)

# spawn a new mob after a certain amount of time has passed
func _on_timer_timeout() -> void:
	spawn_mobs()

# restartign the game by reloading the scene
# have to unpause the scene before reloading or it freezes
func _on_button_pressed():
		get_tree().paused = !get_tree().paused
		get_tree().reload_current_scene()
		
	
