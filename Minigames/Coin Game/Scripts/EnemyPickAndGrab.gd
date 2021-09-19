extends Node

var MousePos
var kinematicBody

var maxSpeed = 3000
var time = 0

var coin = null
var rng = RandomNumberGenerator.new()
var my_random_number

signal deadHand
var player

var invincibleTimer = 8

func _ready():
	kinematicBody = $EnemyKinematicBody
	player = get_node("../PlayerNode")
	
	var x = rng.randf_range(153, 1733)
	var y = rng.randf_range(21, 787)
	kinematicBody.position.x = x
	kinematicBody.position.y = y

#get_viewport().get_mouse_position()

var click = false

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		MousePos = event.position
		if(event.button_index  == BUTTON_LEFT and event.pressed ):
			click = true
		elif(event.button_index  == BUTTON_LEFT and not event.pressed):
			click = false
		
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		MousePos = event.position

func _process(delta):
	#if Input.is_action_pressed("move_forward"):
		#input_movement_vector.y += 1
	#if Input.is_action_pressed("move_back"):
		#input_movement_vector.y -= 1
	time += delta
	
	if(coin == null):
		#bob up and down
		kinematicBody.position.y += sin(time) * 0.25
	else:
		var vec = coin.get_global_position() - kinematicBody.get_global_position()
	
		if(vec.length() >= 500):
			my_random_number = rng.randf_range(-200, 200)
			vec.x += my_random_number
			my_random_number = rng.randf_range(-200, 200)
			vec.y += my_random_number
	
		var velocity = vec.normalized() * maxSpeed
	
		if(vec.length() <= 500):
			velocity -= 1000* vec.normalized()
	
		#kinematicBody.move_and_slide(velocity)
		var collide_info = kinematicBody.move_and_collide(velocity)
	
		if(invincibleTimer <= 0 and collide_info and collide_info.collider and collide_info.collider.is_in_group("Player") and click):
			possible_death()
		
	#kinematicBody.set_global_position(MousePos)
		
	#kinematicBody.set_global_position(MousePos)
	
	invincibleTimer -= delta

func possible_death():
	#check if player is close enough - if he is then die
	"""
	if(kinematicBody):
		
		if((kinematicBody.get_global_position() - player.kinematicBody.get_global_position()).length() <= 50):
			#too close we die
			
			#spawn particle effect "poof"
			
			emit_signal("deadHand")
			queue_free()
	"""
	emit_signal("deadHand")
	
	print("dead hand activated")
	
	queue_free()

func _on_ItemSpawner_spanwedCoin(spanwedCoin):
	coin = spanwedCoin
