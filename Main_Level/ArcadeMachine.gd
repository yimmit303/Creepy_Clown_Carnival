extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player
var debug_draw
var ray

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = $Player
	player = get_node("../Player")
	debug_draw = $DebugDraw
	ray = $Screen/RayCast

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	if Input.is_action_just_pressed("select"):
		""""
		#var space_state = get_world().direct_space_state
		#cast a ray from camera position directly forward from camera
		#var castLength = 1000
		
		#var cameraGlobalTransform = camera_pos.get_global_transform()
		#raycast_now(space_state, cameraGlobalTransform.origin, cameraGlobalTransform.origin + cameraGlobalTransform.basis.z * castLength)
		
		#var mousePos = get_viewport().get_mouse_position()
		#var from = camera.project_ray_origin(mousePos)
		#var to = from + camera.project_ray_normal(mousePos) * castLength
		
		
		var from = transform.origin
		var to = player.transform.origin
		
		#raycast_now(space_state, from, to)
		"""
		ray.enabled = true
		ray.cast_to = player.get_global_transform().origin
		
		ray.force_raycast_update()
		
		var collision = ray.get_collision_point()
		
		print(collision)
		
		if(collision == null):
			collision = player.get_global_transform().origin
		
		debug_draw.setPoints(ray.get_global_transform().origin, ray.get_collision_point())
		
		ray.enabled = false
		
	
"""	
func raycast_now(space_state, from, to):
	var result = space_state.intersect_ray(from, to, [self])
	if(result == null):
		to = result.position
		
	print(from, to)
	
	debug_draw.setPoints(from, to)
"""
