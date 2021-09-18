extends Node2D

var held
export var health = 3
export var shakeTime = 2
export var velocityNeeded = 4

var lastHeld = 0
var time = 0

var rigidBody
var click = false

func _ready():
	held = false
	rigidBody = $RigidBody2D

func startHolding():
	lastHeld = time

func _process(delta):
	time += delta
	if(held and time - lastHeld >= shakeTime and rigidBody.linear_velocity.length > velocityNeeded):
		pass

func _on_RigidBody2D_mouse_entered():
	if Input.is_action_pressed("click"):
		print("yo")
	pass # Replace with function body.

func _on_RigidBody2D_mouse_exited():
	pass # Replace with function body.
