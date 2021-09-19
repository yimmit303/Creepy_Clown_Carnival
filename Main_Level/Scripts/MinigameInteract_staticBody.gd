extends Spatial

var player 
var hand
var rigidBoy

var normalDistanceFromScreen = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = $Player
	
	player = get_node("../../../Player")
	#print(player)
	hand = get_node("../../../Player/HandCollider")
	#print("player: ", player)
	
	rigidBoy = $StaticBody
	
	rigidBoy.cameraZoom = $CameraZoomPoint
	
	rigidBoy.cameraZoom.transform.origin.x = -normalDistanceFromScreen
	rigidBoy.player = player
	
	rigidBoy.connect("interactWith", rigidBoy, "_on_Player_interactWithObject")
	
	#rigidBoy.set_contact_monitor(true)
	#rigidBoy.set_max_contacts_reported(5)
