extends CharacterBody2D

# game over signal
signal health_depleted

# players staring heath
# assigning as a float to make later calculations easier
var health_player = 100.0

func _physics_process(delta):
	
	# movement vector
	# uses wasd keys
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# velocity of the character -> how many pixels per second the character moves
	velocity = direction * 600
	#function to move the character
	move_and_slide()
	
	# if the player's velocity is greater than 0
	if velocity.length() > 0.0:
	#calling the walking animation
	#$HappyBoo works the same as the get_node function
		get_node("HappyBoo").play_walk_animation()
		
	# otherwise play the idle animation
	else:  
		get_node("HappyBoo").play_idle_animation()
		
	#handing the player's damage taken
	
	#rate of damage taken by the player when being attacked by a mob
	const DAMAGE_RATE = 5.0
	
	# getting the mobs that are within the collision range of HurtBox
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	
	# if there are mobs within range to damage the player
	if overlapping_mobs.size() > 0: 
		
		# the player loses health equal to the number of mobs within range, the damage rate and delta
		health_player -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health_player
		
		#if the player's health reaches 0
		if health_player <= 0.0:
			# call signal
			health_depleted.emit()

#displays the game over screen once th player has been defeated
#and pauses the game
func _on_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
