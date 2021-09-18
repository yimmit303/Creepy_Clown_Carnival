extends Node2D

var score = 0
var life = 10

func _ready():
	pass # Replace with function body.

func scored(score):
	if score < 0:
		# damaging wedge
		life -= 1
	else:
		score += 1
		
func _process(delta):
	# TODO add process in for gameover
	pass
