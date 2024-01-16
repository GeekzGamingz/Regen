#Inherits Actor Code
extends Actor
#------------------------------------------------------------------------------#
#Variables
var move_direction = Vector3.ZERO
#Exported Variables
@export_category("Movement Exports")
@export var jump_velocity = 4.5
@export var rotation_speed = 5
@onready var state_output = $Outputs/StateOutput
#------------------------------------------------------------------------------#
#Process
func _process(_delta):
	camera_arm.position = position #Updates Camera
#Physics Process
func _physics_process(delta):
	#Add Gravity
	apply_gravity(delta)
	#Get Input
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	move_direction = move_direction.rotated(Vector3.UP, camera_arm.rotation.y).normalized()
	#Handle Movement
	velocity.x = move_direction.x * max_speed
	velocity.z = move_direction.z * max_speed
	#Handle Run
	if Input.is_action_just_pressed("action_run"):
		max_speed = run_speed
	elif Input.is_action_just_released("action_run"):
		max_speed = walk_speed
	#Handle Jump
	if Input.is_action_just_pressed("action_jump") && check_grounded():
		velocity.y = jump_velocity
	move_and_slide()
	#Turn Player
	if Vector2(velocity.z, velocity.x).length() > 0.2:
		var look_direction = Vector2(velocity.z, velocity.x)
		rotation.y = lerp_angle(rotation.y, look_direction.angle(), delta * rotation_speed)
