extends KinematicBody

const GRAVITY = -24.8
var vel = Vector3()
const MAX_SPEED = 20
const JUMP_SPEED = 18
const ACCEL = 4.5

var dir = Vector3()

const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40

var camera
var rotation_helper
var camera_pos

var MOUSE_SENSITIVITY = 0.05

var interact = false
var hand

var main_camera
var cinematic_camera

var in_minigame = false
var cinematic_camera_ready = false
var current_minigame = null

var debugCamera

var numGamesComplete = 0

signal interactWithObject
signal altarSignal

var ghosts = []

func swapCamera(currentMachine):
	#swap over from main_camera to cinematic_camera and move it into position over the given arcade game!
	
	if(!in_minigame):
		in_minigame = true
		cinematic_camera.transform = main_camera.get_global_transform()
		cinematic_camera.current = true
		main_camera.current = false
		
		#print("cinematic_camera.current: ", cinematic_camera.current, " :: main_camera.current: ", main_camera.current)
		cinematic_camera.transform.origin -= - 2*Vector3.UP #puts camera behind and above player slightly (looks cooler)
		
		cinematic_camera.set_target_path(currentMachine.cameraZoom.get_path())
		cinematic_camera.enabled = true
		cinematic_camera_ready = false
		
		current_minigame = currentMachine

func swapBack():
	#cinematic_camera.transform = main_camera.get_global_transform()
	cinematic_camera.current = true
	main_camera.current = false
	
	#print("cinematic_camera.current: ", cinematic_camera.current, " :: main_camera.current: ", main_camera.current)
	cinematic_camera.transform.origin -= - 2*Vector3.UP #puts camera behind and above player slightly (looks cooler)
	
	cinematic_camera.set_target_path(main_camera.get_path())
	cinematic_camera.enabled = true
	cinematic_camera_ready = false
	
	current_minigame = null
	

func _ready():
	camera = $Pivot/CameraPivot/Camera
	rotation_helper = $Pivot
	camera_pos = $Pivot/CameraPivot
	
	hand = $HandCollider
	hand.player = self
	
	$AudioStreamPlayer.play()
	
	main_camera = $Pivot/CameraPivot/Camera
	#cinematic_camera = $Pivot/CameraPivot/InterpolatedCamera
	cinematic_camera = get_node("../CinematicCamera")
	debugCamera = get_node("../Debug/DebugCamera")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	process_input(delta)
	if(!in_minigame):
		process_movement(delta)
	else:
		if(!cinematic_camera_ready):
			check_camera_progress()
		else:
			#start minigame here!
			if(current_minigame and !current_minigame.running):
				#print('in player starting game')
				self.visible = false
				hand.set_monitoring(false)
				hand.set_monitorable(false)
				#handModel.visible = false
				$AudioStreamPlayer.stop()
				current_minigame.startGame()

func stop_mini_game():
	#print("stopping game")
	self.visible = true
	#handModel.visible = true
	in_minigame = false
	
	hand.set_monitoring(true)
	hand.set_monitorable(true)
	
	main_camera.current = true
	debugCamera.current = false
	cinematic_camera.current = false
	
	$AudioStreamPlayer.play()

func check_camera_progress():
	var location = cinematic_camera.get_global_transform().origin
	var destination = get_node(cinematic_camera.get_target_path()).get_global_transform().origin
	var diff = location - destination
	
	if(diff.length() < 0.01):
		cinematic_camera.enabled = false
		cinematic_camera_ready = true

func process_input(_delta):
	# ----------------------------------
	# Walking
	dir = Vector3()
	var cam_xform = camera.get_global_transform()

	var input_movement_vector = Vector2()

	if Input.is_action_pressed("move_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("move_back"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("move_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_movement_vector.x += 1

	input_movement_vector = input_movement_vector.normalized()

	# Basis vectors are already normalized.
	dir += -cam_xform.basis.z * input_movement_vector.y
	dir += cam_xform.basis.x * input_movement_vector.x
	# ----------------------------------

	# ----------------------------------
	# Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("move_jump"):
			vel.y = JUMP_SPEED
	# ----------------------------------

	# ----------------------------------
	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# ----------------------------------
	
	#-----------------------------------
	if Input.is_action_just_pressed("select"):
		interact = true
		
	if Input.is_action_just_released("select"):
		interact = false
	#-----------------------------------
	
func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * GRAVITY

	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))
	
	#if get_slide_count() != 0 :
		#for i in range (0, get_slide_count()):
			#print(get_slide_collision(i))
			#print(get_slide_collision(i).collider.name)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot


func _on_ArcadeRigidBody_completed_minigame(name):
	print("completed miniGame! ", name)
	
	if(!ghosts.has(name)):
		ghosts.append(name)
		numGamesComplete += 1
	
	emit_signal("altarSignal", name)

func _on_HandCollider_interactWith(object):
	#print("player interact with: ", object.name)
	emit_signal("interactWithObject", object)
