extends Spatial

var body
var player 
var hand

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = $Player
	
	player = get_node("../Player")
	hand = get_node("../Player/HandCollider")
	#print(player)
	
	body = $ArcadeRigidBody
	
	body.set_contact_monitor(true)
	body.set_max_contacts_reported(5)
	
	body.connect("body_entered", self, "on_player_interact")
	
	body.connect("body_exited", self, "on_player_leave")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func on_player_leave(body):
	print("arcade no longer touching ", body.name)
	if(body.name == player.name):
		print("not touching player.")
		hand.currentMachine = null
	if(body.name == hand.name):
		print("not hand on machine.")
		hand.ready_to_play = false
		hand.currentMachine = null

func on_player_interact(body):
	print("arcade machine touched: ", body.name)
	if(body.name == player.name):
		print("touched player!!!")
		hand.currentMachine = self
	if(body.name == hand.name):
		print("hand on machine!!!")
		hand.currentMachine = self
