extends Node2D

var active = false
var num_popped = 0

func _ready():
	make_active()

func make_active():
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Timer.counting = true
	$Music.play()

func make_inactive():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Timer.counting = false
	$Music.stop()

func _on_game_won():
	make_inactive()
	$BalloonSpawner.pop_all()
	$WinScreen.play()
	yield($WinScreen, "done_playing")

func _on_game_lost():
	make_inactive()
	$BalloonSpawner.pop_all()
	$LoseScreen.play()
	yield($LoseScreen, "done_playing")

func _on_balloon_popped():
	num_popped += 1
	if num_popped == 3:
		_on_game_won()
