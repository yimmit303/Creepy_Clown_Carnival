extends Node2D

export var health = 3
export var shakeTime = 5
export var maxSpeed = 1200

var lastHeld = 0
var time = 0

var rigidBody
var ontopOf = false
var grabbed = false
var particles

func _ready():
	rigidBody = $RigidBody2D
	particles = $RigidBody2D/DustParticles
	particles.emitting = false
	rigidBody.gravity_scale = 0

func startHolding():
	lastHeld = time
	grabbed = true
	#print("grabbed")

func _process(delta):
	time += delta
	
	if(grabbed):
		var d = get_global_mouse_position()-global_position
		#print(d.length())
		var v = (d).normalized() * maxSpeed * delta * d.length()/125
		if(d.length() >= 5):
			position += v
			particles.emitting = true
		else:
			lastHeld += delta
			particles.emitting = false
		#print(v)
		
		if(time - lastHeld >= shakeTime):
			lastHeld = time
			
			if(health == 3):
				$RigidBody2D/Edges.visible = false
			elif(health == 2):
				$RigidBody2D/Center.visible = false
			elif(health == 1):
				$RigidBody2D/Center.visible = false
			elif(health <= 0):
				#destroy self
				#spawn coin
				queue_free()
				pass
			health -= 1
			
func _on_RigidBody2D_mouse_entered():
	ontopOf = true
	pass # Replace with function body.

func _on_RigidBody2D_mouse_exited():
	ontopOf = false
	pass # Replace with function body.

func _on_Node2D_leftClickedSignal():
	if(ontopOf):
		print("holding")
		startHolding()
	pass # Replace with function body.

func _on_Node2D_leftUnclickedSignal():
	if(grabbed):
		grabbed = false
		#rigidBody.gravity_scale = 20
		print("let go")
	pass # Replace with function body.
