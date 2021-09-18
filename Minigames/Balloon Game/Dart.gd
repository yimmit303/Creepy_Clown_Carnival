extends Node2D


func _ready():
	pass # Replace with function body.


func _process(delta):
	$Reticle.position = get_viewport().get_mouse_position()
