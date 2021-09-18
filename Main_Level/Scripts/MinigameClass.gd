extends Node

var cameraZoom
var running = false
var player
export var runOnce = false

func startGame():
	#this will start the game
	running = true
	print("starting game now!")
	
	#wait
	var t = Timer.new()
	t.set_wait_time(4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	#done waiting
	
	finishGame()
	
func finishGame():
	running = false
	print("finished game: ", player)
	player.stop_mini_game()
	
	if(runOnce):
		#destroys this things parent!
		get_node("../").queue_free()
		
func _ready():
	cameraZoom = self

