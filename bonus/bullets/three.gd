extends Bonus

func set_sprite():
	$Bonus/Sprite2D.set_texture(load("res://art/weapon_bonus.png"))

func effect():
	get_parent().get_parent().bullet_number = 3
	if _player.get_children().size() == 3:
		_player.remove_child(_player.get_child(2))
