extends Bonus

func effect():
	get_parent().get_parent().bullet_number = 2
	if _player.get_children().size() == 3:
		_player.remove_child(_player.get_child(2))
