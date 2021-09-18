extends Node2D

var active = false
var num_popped = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	make_active()

func make_active():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$DartThrower.can_throw = true
	$Timer.counting = true

func make_inactive():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$DartThrower.can_throw = false
	$Timer.counting = false

func _on_game_won():
	make_inactive()
	$BalloonSpawner.pop_all()
	$WinScreen.play()
	yield($WinScreen, "done_playing")

func _on_game_lost():
	if num_popped < 3: # This stops the win and loss from happening at the same time
		make_inactive()
		$BalloonSpawner.pop_all()
		$LoseScreen.play()
		yield($LoseScreen, "done_playing")

func _on_balloon_popped():
	num_popped += 1
	if num_popped == 3:
		_on_game_won()
