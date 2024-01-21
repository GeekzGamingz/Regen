@tool
#Inherits Node3D Code
extends Node3D
#------------------------------------------------------------------------------#
#Variables
var PARTITION_CLIPMAP = preload("res://source/World/ProcGen/ClipMap/ClipMapPartition.tscn")
var PARTITION_GRASS = preload("res://source/World/ProcGen/GrassPartition.tscn")
var length = ProjectSettings.get_setting("shader_globals/clipmap_partition_length").value
#Exported Variables
@export var distance: int = 8
@onready var p = get_parent()
#------------------------------------------------------------------------------#
#Ready
func _ready():
	generate_world()
#------------------------------------------------------------------------------#
func generate_world():
	for x in range(-distance, distance + 1):
		for z in range (-distance, distance + 1):
			var partition = PARTITION_CLIPMAP.instantiate()
			#Assign Partition Coordinates
			partition.x = x
			partition.z = z
			#Add to Tree
			add_child(partition)
#------------------------------------------------------------------------------#
#Physics Process
func _physics_process(_delta):
	if p.player != null:
		global_position = p.player.global_position.snapped(Vector3.ONE * length) * Vector3(1, 0, 1)
		RenderingServer.global_shader_parameter_set("clipmap_position", global_position)
