extends KinematicBody2D
var rate = 15
var cur_angle = 0

func _ready():
	pass


func turn(n, dt):
	# Turns wheel n degrees per second
	var angle = (n * dt) * (PI / 180)
	cur_angle += (n * dt)
	self.rotate(angle)

func hit():
	var good = false
	var turned = int(cur_angle) % 360
	var slice = turned / 45
	if slice % 2 == 0:
		good = true
	else:
		good = false

func _process(delta):
	turn(rate, delta)
