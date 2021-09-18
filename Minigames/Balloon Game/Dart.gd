extends Node2D

var offset = Vector2(0, 0)
var time = 0

func _ready():
	pass # Replace with function body.


func _process(delta):
	$Reticle.position = get_viewport().get_mouse_position() + offset
	offset.y = 25 * sin(4*time)
	offset.x = 25 * sin(2*time + PI)
	time += delta
