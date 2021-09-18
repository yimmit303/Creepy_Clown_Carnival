extends KinematicBody2D
var rate = 90

func _ready():
	pass


func turn(n, dt):
	# Turns wheel n degrees per second
	var angle = (n * dt) * (PI / 180)
	self.rotate(angle)


func _process(delta):
	turn(rate, delta)
