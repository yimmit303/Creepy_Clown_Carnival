extends Node2D

var MousePos
var leftHeld
var rightHeld

signal leftClickedSignal
signal leftUnclickedSignal

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		MousePos = event.position
		
		if(event.button_index  == BUTTON_LEFT and event.pressed ):
			#print("left click pressed")
			leftHeld  = true
			emit_signal("leftClickedSignal")
			
		elif(event.button_index  == BUTTON_LEFT and not event.pressed):
			#print("left click released")
			leftHeld = false
			emit_signal("leftUnclickedSignal")
			
		if(event.button_index  == BUTTON_RIGHT and event.pressed ):
			#print("right click pressed")
			rightHeld = true
		elif(event.button_index  == BUTTON_RIGHT and not event.pressed):
			#print("right click released")
			rightHeld = false
		
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		MousePos = event.position

	# Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport_rect().size)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
