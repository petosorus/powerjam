extends Bonus

func set_sprite():
	$Bonus/Sprite2D.set_texture(load("res://art/time_bonus.png"))

func effect():
	var main = get_parent().get_parent()
	var timer: Timer = main.get_child(2)
	timer.stop()
	timer.set_wait_time(1.5)
	timer.start()
