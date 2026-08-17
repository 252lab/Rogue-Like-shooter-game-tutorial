extends CharacterBody2D

# health of the mob
var health = 3

# doesn't need player input as ai
# therefore relies on calculations to move it

#variable for holding the player
@onready var player = get_node("/root/Game/player")

#function for playing the walk animation - using the ready function
func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	
	#where the mob is located in the game world in relation to the player
	var direction = global_position.direction_to(player.global_position)
	
	# movement velocity of the mob
	velocity = direction * 300.0
	move_and_slide()

#handles the mobs taking damage and destroying them once their health hits 0
func take_damage():
	health -=  1
	
	# playing the slime hurt animation
	%Slime.play_hurt()
	
	if health == 0:
		
		#increase the player's score by one
		player.score += 1
		
		# remove the slime object
		queue_free()
		
		#load the smoke explosion animation
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		
		# make a copy of the constant
		var smoke = SMOKE_SCENE.instantiate()
		
		#adding the smoke scene as a child of mob
		get_parent().add_child(smoke)
		
		# play the animation at the location where the mob dies
		smoke.global_position = global_position
