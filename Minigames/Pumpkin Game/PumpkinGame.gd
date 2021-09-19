extends Node2D

var active = false


func _ready():
	make_active()

func _process(_delta):
	if active:
		$LineDrawer.update_variables($Hook/HookPoint.global_position, $Rod/RodPoint.global_position)

func make_active():
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.active = true
	$Hook.can_hook = true
	$Timer.counting = true
	$Music.play()

func make_inactive():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.active = false
	$Hook.can_hook = false
	$Timer.counting = false
	$Music.stop()

func _on_game_won():
	make_inactive()
	$WinScreen.play()
	yield($WinScreen, "done_playing")

func _on_game_lost():
	make_inactive()
	$LoseScreen.play()
	yield($LoseScreen, "done_playing")
