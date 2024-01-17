extends Node3D
#------------------------------------------------------------------------------#
var PARTITION = preload("res://source/world/ProcGen/ClipMap/ClipMapPartition.tscn")
@export var distance: int = 8
#------------------------------------------------------------------------------#
var length = ProjectSettings.get_setting("shader_globals/clipmap_partition_length").value
#------------------------------------------------------------------------------#
func _ready():
	for x in range(-distance, distance + 1):
		for z in range (-distance, distance + 1):
			var partition = PARTITION.instantiate()
			#Assign Partition Coordinates
			partition.x = x
			partition.z = z
			#Add to Tree
			add_child(partition)
#------------------------------------------------------------------------------#
func _physics_process(_delta):
	global_position = G.PLAYER.global_position.snapped(Vector3.ONE * length) * Vector3(1, 0, 1)
	RenderingServer.global_shader_parameter_set("clipmap_position", global_position)
	rotation.y = 0
