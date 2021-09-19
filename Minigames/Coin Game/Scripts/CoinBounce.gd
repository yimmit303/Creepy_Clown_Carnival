extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var velocity = Vector2(20, -800)
export var gravity = 500
export var decay = 0.90

var humanScore = 0
var evilScore = 0

var humanTouch = 0
var evilTouch = 0

#signal playerTouch
#signal enemyTouch
signal coinGone

var currentParent = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if(get_parent().active):
		$Timer.counting = true
		$Timer.time_left = 10
	pass
	
func _physics_process(delta):
	if(get_parent().active):
		var collision_info = move_and_collide(velocity * delta)
		#var collision_info = move_and_slide (velocity * delta)
		
		if(collision_info):
			velocity = velocity.bounce(collision_info.normal) * decay
		
		if(collision_info and collision_info.collider.is_in_group("Player")):
			#print(collision_info.collider.name)
			#print(velocity.length())
			humanTouch += 1
			currentParent = collision_info.collider
			if(velocity.length() <= 900):
				velocity *= 1.1
		elif(collision_info and collision_info.collider.is_in_group("Enemy")):
			#print(collision_info.collider.name)
			#print(velocity.length())
			evilTouch += 1
			currentParent = collision_info.collider
			if(velocity.length() <= 1000):
				velocity *= 2.0
		else:
			currentParent = null
		velocity += Vector2(0, 1) * gravity * delta
		
		if(currentParent != null):
			#bounce away
			var vec = currentParent.get_global_position() - get_global_position()
			vec = vec.normalized() * -300
			velocity += vec
		
	# Called every frame. 'delta' is the elapsed time since the previous frame.
	#func _process(delta):
	#	pass


func _on_Timer_time_out():
	#print("time's up")
	$Timer.counting = false
	emit_signal("coinGone", evilTouch < humanTouch, get_path())
