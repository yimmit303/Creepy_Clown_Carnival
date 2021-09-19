extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var velocity = Vector2(20, 800)
export var gravity = 1000
export var decay = 0.70

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if(collision_info):
		velocity = velocity.bounce(collision_info.normal) * decay
		
	velocity += Vector2(0, 1) * gravity * delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
