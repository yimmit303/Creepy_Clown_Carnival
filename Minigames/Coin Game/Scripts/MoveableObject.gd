extends Node2D

export var health = 3
export var shakeTime = 2
export var maxSpeed = 1200

var lastHeld = 0
var time = 0

var rigidBody
var ontopOf = false
var grabbed = false
var particles
var MousePos

signal spawnCoin

var rng = RandomNumberGenerator.new()
var my_random_number

func _ready():
	rigidBody = $RigidBody2D
	particles = $RigidBody2D/DustParticles
	particles.emitting = false
	rigidBody.gravity_scale = 0
	
	var x = rng.randf_range(153, 1733)
	var y = rng.randf_range(21, 787)
	position.x = x
	position.y = y

func startHolding():
	lastHeld = time
	grabbed = true
	#print("grabbed")

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		MousePos = event.position
		
		if(event.button_index  == BUTTON_LEFT and event.pressed ):
			_on_Node2D_leftClickedSignal()
			
		elif(event.button_index  == BUTTON_LEFT and not event.pressed):
			_on_Node2D_leftUnclickedSignal()
		
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		MousePos = event.position

func _process(delta):
	time += delta
	
	if(grabbed):
		var d = get_global_mouse_position()-rigidBody.get_global_position()
		#print(d.length())
		var v = (d).normalized() * maxSpeed * delta * d.length()/125
		if(d.length() >= 5):
			rigidBody.position += v
			particles.emitting = true
		else:
			lastHeld += delta
			particles.emitting = false
		#print(v)
		
		if(time - lastHeld >= shakeTime-(3-health)):
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
				
				emit_signal("spawnCoin", rigidBody)
				
				queue_free()
				pass
			health -= 1
			
func _on_RigidBody2D_mouse_entered():
	ontopOf = true
	#print("hovering")
	pass # Replace with function body.

func _on_RigidBody2D_mouse_exited():
	ontopOf = false
	#print("stopped hovering")
	pass # Replace with function body.

func _on_Node2D_leftClickedSignal():
	if(ontopOf):
		#print("clicked on")
		startHolding()
	pass # Replace with function body.

func _on_Node2D_leftUnclickedSignal():
	if(grabbed):
		grabbed = false
		#rigidBody.gravity_scale = 20
		#print("let go")
	pass # Replace with function body.
