extends Node2D

var Balloon = load("Minigames/Balloon Game/Balloon.gd")

var balloon_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(4):
		for y in range(4):
			balloon_list.append(Balloon.new())
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
