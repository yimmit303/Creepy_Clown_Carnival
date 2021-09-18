extends RigidBody

var player 
var ready_to_play = false
var currentMachine #is set by arcade machine

var collisionShape

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../../Player")
	
	collisionShape = $PlayerHandCollisionShape

	set_contact_monitor(true)
	set_max_contacts_reported(5)
	
func _process(delta):
	if(ready_to_play and player.interact and !player.in_minigame):
		#print("start game!")
		
		#ready_to_play and currentMachine are set via arcade machine
		if(currentMachine):
			player.swapCamera(currentMachine)
			
			player.interact = false
			ready_to_play = false
