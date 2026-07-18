extends Area2D

# tracks how far the bullet has travelled
var travelled_distance = 0

func _physics_process(delta):

	# when moving area nodes, use position or global_position
	# have to take rotation of bullet into account for movement
	
	#speed of the bullet
	const SPEED = 1000.0
	
	#Range of the bullet (how far can it hit the enemy)
	const RANGE = 1200.0

#vector 2 -> any 2d vector
# checks the direction of the bullet
	var direction = Vector2.RIGHT.rotated(rotation)
	
#moves the bullet in the correct direction
# delta has to be manually applied here as move_and_slide function doesn't work
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	
	# if the bullet has gone out of range, destory it
	if travelled_distance > RANGE:
		queue_free()
	
#signal for handling what happens when a bullet collides with something
func _on_body_entered(body: Node2D) -> void:
	
	# delete the bullet
	queue_free()
	
	# check that object that is collided with can take damage
	if body.has_method("take_damage"):
		 # if it can, call the method
		body.take_damage()
