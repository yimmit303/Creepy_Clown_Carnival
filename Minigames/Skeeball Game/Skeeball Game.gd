extends Node2D

var score = 0
var ammo = 20
var min_score = 300
var done = false
var timer = 2.0

func final_check():
	if score >= min_score and ammo == 0:
		_on_game_won()
	elif score <= min_score and ammo == 0:
		_on_game_lost()

func _process(delta):
	if ammo <= 0:
		timer -= delta
	if timer <= 0 and not done:
		timer = 2.0
		done = true
		final_check()
	$Scoreboard.print_text("Score: " + str(score)
	 + "\n" + "Ammo: " + str(ammo) +
	 "\n" + "Minimum score needed: " + str(min_score))
	
func make_active():
	done = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Skeeball_Spawner.activate()
	$Moosic.play()
	
func make_inactive():
	$Skeeball_Spawner.disable()
	$Moosic.stop()


func _on_Skeeball_Ramp_pass_on(value):
	score += value

func _on_game_won():
	make_inactive()
	$WinScreen.play()
	yield($WinScreen, "done_playing")

func _on_game_lost():
	make_inactive()
	$LoseScreen.play()
	yield($LoseScreen, "done_playing")
