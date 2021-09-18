extends Spatial

var player 
var hand
var rigidBoy

var normalDistanceFromScreen = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = $Player
	
	player = get_node("../Player")
	hand = get_node("../Player/HandCollider")
	#print("player: ", player)
	
	rigidBoy = $ArcadeRigidBody
	
	rigidBoy.cameraZoom = $ArcadeRigidBody/ArcadeScreen/CameraSnapLocation #this must be oriented so that it faces the screen
	
	var physicalScreen = $ArcadeScreen
	rigidBoy.cameraZoom.transform.origin.x = -normalDistanceFromScreen
	rigidBoy.player = player
	
	rigidBoy.set_contact_monitor(true)
	rigidBoy.set_max_contacts_reported(5)
