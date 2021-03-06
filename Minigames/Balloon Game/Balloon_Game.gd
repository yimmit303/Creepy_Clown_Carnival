extends Node2D

signal game_won
signal game_lost

var active = false
var num_popped = 0

func make_active():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$BalloonSpawner.spawn_balloons()
	$DartThrower.can_throw = true
	$Timer.counting = true
	$Music.play()

func make_inactive():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$DartThrower.can_throw = false
	$Timer.counting = false
	$Music.stop()

func _on_game_won():
	make_inactive()
	$BalloonSpawner.pop_all()
	$WinScreen.play()
	yield($WinScreen, "done_playing")
	emit_signal("game_won")

func _on_game_lost():
	if num_popped < 3: # This stops the win and loss from happening at the same time
		make_inactive()
		$BalloonSpawner.pop_all()
		$LoseScreen.play()
		yield($LoseScreen, "done_playing")
		emit_signal("game_lost")

func _on_balloon_popped():
	num_popped += 1
	if num_popped == 3:
		_on_game_won()
