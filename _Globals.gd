#Inherits Node3D Code
extends Node
#------------------------------------------------------------------------------#
#Constants
#------------------------------------------------------------------------------#
#Variables
var hm_image: Image = load(ProjectSettings.get_setting("shader_globals/heightmap").value).get_image()
var hmImage_size = hm_image.get_width()
var amplitude: float = ProjectSettings.get_setting("shader_globals/amplitude").value
var sea_level: float = 4.25
#OnReady Variables
@onready var PLAYER = get_tree().get_root().get_node("WorldRoot/Kinematics/Player")
@onready var KINEMATICS = get_tree().get_root().get_node("WorldRoot/Kinematics")
@onready var UI = get_tree().get_root().get_node("WorldRoot/UIRoot")
#------------------------------------------------------------------------------#
#Globals Functions
func get_height(x, z):
	@warning_ignore("narrowing_conversion")
	return hm_image.get_pixel(fposmod(x, hmImage_size), fposmod(z, hmImage_size)).r * amplitude
