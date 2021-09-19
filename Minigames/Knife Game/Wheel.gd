extends KinematicBody2D
var difficulty = 5
var rate = 15
var cur_angle = 0

func _ready():
	pass


func turn(n, dt):
	# Turns wheel n degrees per second
	var angle = (n * dt) * (PI / 180) * difficulty
	cur_angle += (n * dt) * difficulty
	self.rotate(angle)

func hit():
	var score = 0
	var turned = int(cur_angle) % 360
	var slice = turned / 45.0
	if int(slice) % 2 != 0:
		score = 1
	else:
		score = -1
	self.get_parent().scored(score)

func _process(delta):
	turn(rate, delta)
