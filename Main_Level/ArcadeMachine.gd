extends Spatial

var body
var player 
var hand

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = $Player
	
	player = get_node("../Player")
	hand = get_node("../Player/HandBody")
	#print(player)
	
	body = $ArcadeRigidBody
	
	body.set_contact_monitor(true)
	body.set_max_contacts_reported(5)
	
	body.connect("body_entered", self, "on_player_interact")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_player_interact(body):
	print("arcade machine touched: ", body.name)
	if(body.name == player.name):
		print("touched player!!!")
	if(body.name == hand.name):
		print("start game!")
