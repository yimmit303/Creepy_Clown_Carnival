extends Node2D

signal time_out

var counting = false
var time_left = 20.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if counting:
		self.time_left -= delta
		$TimeLeft.text = str(time_left).left(4)
