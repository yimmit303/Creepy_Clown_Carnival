extends RigidBody

var player 
var ready_to_play = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../../Player")

	set_contact_monitor(true)
	set_max_contacts_reported(5)
	
	connect("body_entered", self, "on_player_interact")
	
	connect("body_exited ", self, "on_player_leave")

func on_player_leave(body):
	print("no longer touching ", body.name)
	ready_to_play = false

func on_player_interact(body):
	print("player hand touched ", body.name)
	ready_to_play = true
	
func _process(delta):
	if(ready_to_play and player.interact):
		print("start game!")
		
		#start game here or something
		
		player.interact = false
		ready_to_play = false
