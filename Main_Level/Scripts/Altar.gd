extends Node

var mesh

export var minigameName = "name"
export var ready = false

var handMesh

func _ready():
	mesh = $Idol
	mesh.visible = false

func _on_ArcadeRigidBody_completed_minigame(name):
	print("checking: ", name, " vs ", minigameName)
	if(name == minigameName):
		print("foudn ya")
		ready = true
		#print("ready")


func _on_Player_altarSignal(name):
	print("checking: ", name, " vs ", minigameName)
	if(name == minigameName):
		print("found!")
		ready = true
		#print("ready")y.
