extends Node

var MousePos
var kinematicBody

export var coins = 0

func _ready():
	kinematicBody = $PlayerKinematicBody
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

#get_viewport().get_mouse_position()

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		MousePos = event.position
			
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		MousePos = event.position

func _process(delta):
	#if Input.is_action_pressed("move_forward"):
		#input_movement_vector.y += 1
	#if Input.is_action_pressed("move_back"):
		#input_movement_vector.y -= 1
		
	kinematicBody.set_global_position(MousePos)
		
	#kinematicBody.set_global_position(MousePos)


func _on_ItemSpawner_addOneToPlayerCoins():
	coins += 1
