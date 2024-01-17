extends CollisionShape3D

@export var template_mesh: PlaneMesh
@onready var faces = template_mesh.get_faces()
@onready var snap = Vector3.ONE * template_mesh.size.x / 2
@onready var player = G.PLAYER

func _ready():
	update_shape()

func _physics_process(_delta):
	var pRound_POS = player.global_position.snapped(snap) * Vector3(1, 0, 1)
	if !global_position == pRound_POS:
		global_position = pRound_POS
		update_shape()

func update_shape():
	for f in faces.size():
		var global_vert = faces[f] + global_position
		faces[f].y = G.get_height(global_vert.x, global_vert.z)
	self.shape.set_faces(faces)
	#rotation.y = 0
