extends Node

var cameraZoom
var running = false
var player
export var runOnce = false

export var wonGame = true

signal completed_minigame

func startGame():
	#this will start the game
	running = true
	#print("starting game now!")
	
	var game = $game
	if(game != null):
		game.visible = true
		game.make_active()
	
	"""
	#wait
	var t = Timer.new()
	t.set_wait_time(4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	#done waiting
	"""
	
func finishGame():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	running = false
	#print("finished game: ", player)
	player.stop_mini_game()
	
	if(wonGame):
		playerCompletedGameSuccessfully()
	
	#emit_signal("completed_minigame", self.name)
	
	if(runOnce):
		#destroys this things parent!
		get_node("../").queue_free()
		
func playerCompletedGameSuccessfully():	
	print("comepleted game!")
	player._on_ArcadeRigidBody_completed_minigame(self.get_parent().name)
		
func _ready():
	cameraZoom = self

func _on_Player_interactWithObject(object):
	if(object == self):
		player.swapCamera(self)
		player.interact = false
		player.hand.ready_to_play = false


func _on_game_game_won():
	wonGame = true
	var game = $game
	if(game != null):
		game.visible = false
	finishGame()

func _on_game_game_lost():
	wonGame = false
	var game = $game
	if(game != null):
		game.visible = false
	finishGame()
