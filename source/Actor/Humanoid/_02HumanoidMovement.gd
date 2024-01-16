#Inherits Actor Code
extends Actor
#------------------------------------------------------------------------------#
func _physics_process(delta):
	#Add Gravity
	apply_gravity(delta)
	move_and_slide()
