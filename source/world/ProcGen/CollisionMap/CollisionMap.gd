#Inherits CollisionShape3D Code
extends CollisionShape3D
#------------------------------------------------------------------------------#
#Variables
#Exported Variables
@export var template_mesh: PlaneMesh
#OnReady Variables
@onready var faces = template_mesh.get_faces()
@onready var snap = Vector3.ONE * template_mesh.size.x / 2
@onready var player = G.PLAYER
#------------------------------------------------------------------------------#
#Ready
func _ready():
	update_shape()
#------------------------------------------------------------------------------#
#Physics Process
func _physics_process(_delta):
	var pRound_POS = player.global_position.snapped(snap) * Vector3(1, 0, 1)
	if !global_position == pRound_POS:
		global_position = pRound_POS
		update_shape()
#------------------------------------------------------------------------------#
#Update Clipmap
func update_shape():
	for f in faces.size():
		var global_vert = faces[f] + global_position
		faces[f].y = G.get_height(global_vert.x, global_vert.z)
	shape.set_faces(faces)
