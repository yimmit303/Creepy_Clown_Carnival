extends Node2D

var total = 0
var life = 10
signal game_won()
signal game_lost()

func make_active():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$WinScreen.reset()
	$LoseScreen.reset()
	$Knife_Spawner.reset()
	$Knife_Spawner.activate()
	$Moosic.play()
	
func scored(score):
	if score < 0:
		life -= 1
		_on_game_lost()
	else:
		total += 1
		_on_game_won()
		
func make_inactive():
	$Knife_Spawner.disable()
	$Moosic.stop()
	
func _process(delta):
	$Scoreboard.print_text("Lives: " + str(life) + "\n" + "Score: " + str(total))
	
func _on_game_won():
	if total >= 10:
		make_inactive()
		$WinScreen.play()
		yield($WinScreen, "done_playing")
		emit_signal("game_won")

func _on_game_lost():
	if life <= 0:
		make_inactive()
		$LoseScreen.play()
		yield($LoseScreen, "done_playing")
		emit_signal("game_lost")
