extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var leftSide
var rightSide

var aliveObjects = []

# Called when the node enters the scene tree for the first time.
func _ready():
	leftSide = $SpawnLocation_Left
	rightSide = $SpawnLocation_Right

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
