extends Node

var cameraZoom
var running = false
var player
export var runOnce = false

export var wonGame = true

export var miniGamePath = ""
var gamePrefab

signal completed_minigame

func startGame():
	#this will start the game
	running = true
	#print("starting game now!")
	if(gamePrefab):
		makeMinigame()
	
	var game = $game
	if(game != null):
		game.visible = true
		game.make_active()
	else:
		wonGame = true
		finishGame()
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
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Input.grab_focus()
	running = false
	#print("finished game: ", player)
	player.stop_mini_game()
	
	if(wonGame):
		playerCompletedGameSuccessfully()
	
	#emit_signal("completed_minigame", self.name)
	
	if(runOnce):
		#destroys this things parent!
		get_node("../").queue_free()
		
	var game = $game
	if(game):
		game.queue_free()
		
func playerCompletedGameSuccessfully():	
	print("comepleted game!")
	player._on_ArcadeRigidBody_completed_minigame(self.get_parent().name)
		
func _ready():
	cameraZoom = self
	if(miniGamePath != null or miniGamePath.length() > 0):
		gamePrefab = load(miniGamePath)
	else:
		gamePrefab = null

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
		game.queue_free()
		
	finishGame()

func makeMinigame():
	var game
	game = gamePrefab.instance()
	game.set_name("game")
	add_child(game)
	
	game.connect("game_won", self, "_on_game_game_won")
	game.connect("game_lost", self, "_on_game_game_lost")
