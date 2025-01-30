extends Bonus

func effect():
	var main = get_parent().get_parent()
	var timer: Timer = main.get_child(2)
	timer.stop()
	timer.set_wait_time(2.5)
	timer.start()
