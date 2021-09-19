extends Node

var mesh

export var minigameName = "name"
var ready = false

func _ready():
	mesh = $Idol
	mesh.visible = false

func _on_ArcadeRigidBody_completed_minigame(name):
	if(name == minigameName):
		ready = true
		#print("ready")
