extends RigidBody

var player 
var hand

var screen
var normalDistanceFromScreen = 15
var running = false

func startGame():
	#this will start the game
	running = true
	print("starting game now!")
	
	#wait
	var t = Timer.new()
	t.set_wait_time(6)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	#done waiting
	
	finishGame()
	
func finishGame():
	running = false
	print(player)
	player.stop_mini_game()

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = $Player
	
	player = get_node("../../Player")
	hand = get_node("../../Player/HandCollider")
	#print(player)
	
	screen = $ArcadeScreen/CameraSnapLocation #this must be oriented so that it faces the screen
	
	var physicalScreen = $ArcadeScreen
	#var forward = Vector3.ZERO
	#forward = physicalScreen.get_global_transform().basis.y
	#screen.transform.origin += normalDistanceFromScreen * forward
	
	screen.transform.origin.x = -normalDistanceFromScreen
	
	set_contact_monitor(true)
	set_max_contacts_reported(5)
