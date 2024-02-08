#Inherits Node3D Code
extends Node
#------------------------------------------------------------------------------#
#Constants
#------------------------------------------------------------------------------#
#Variables
var hmap_img: Image = load(ProjectSettings.get_setting("shader_globals/heightmap").value).get_image()
var hmImage_size = hmap_img.get_width()
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
	return hmap_img.get_pixel(fposmod(x, hmImage_size), fposmod(z, hmImage_size)).r * amplitude
	#var width = hmap_img.get_width()
	#var height = hmap_img.get_height()
	#var pixel_x = (width / 2) + x 
	#var pixel_z = (height / 2) + z
	#
	#if pixel_x > width: pixel_x -= width 
	#if pixel_z > height: pixel_z -= height 
	#if pixel_x < 0: pixel_x += width 
	#if pixel_z < 0: pixel_z += height 
 #
	#var color = hmap_img.get_pixel(pixel_x, pixel_z)
	#return color.r * amplitude# * v_scale
