extends Bonus

func effect():
	var main = get_parent().get_parent()
	#main.get_child(2).set_wait_time(1)
	var timer: Timer = main.get_child(2)
	timer.stop()
	timer.set_wait_time(1)
	timer.start()
	
