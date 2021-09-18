extends Spatial

var body
var player 
var hand

var screen
var normalDistanceFromScreen = 15
var started = false

func startGame():
	#this will start the game
	started = true
	print("starting game now!")
	
	#wait
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	#done waiting
	
	finishGame()
	
func finishGame():
	started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = $Player
	
	player = get_node("../Player")
	hand = get_node("../Player/HandCollider")
	#print(player)
	
	body = $ArcadeRigidBody
	screen = $ArcadeRigidBody/ArcadeScreen/CameraSnapLocation #this must be oriented so that it faces the screen
	
	var physicalScreen = $ArcadeRigidBody/ArcadeScreen
	#var forward = Vector3.ZERO
	#forward = physicalScreen.get_global_transform().basis.y
	#screen.transform.origin += normalDistanceFromScreen * forward
	
	screen.transform.origin.x = -normalDistanceFromScreen
	
	body.set_contact_monitor(true)
	body.set_max_contacts_reported(5)
	
	body.connect("body_entered", self, "on_player_interact")
	
	body.connect("body_exited", self, "on_player_leave")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_player_leave(body):
	#print("arcade no longer touching ", body.name)
	if(body.name == player.name or body.name == hand.name):
		#print("not hand on machine.")
		hand.ready_to_play = false
		hand.currentMachine = null

func on_player_interact(body):
	#print("arcade machine touched: ", body.name)
	if(body.name == player.name or body.name == hand.name):
		#print("touched player!!!")
		hand.currentMachine = self
		hand.ready_to_play = true
