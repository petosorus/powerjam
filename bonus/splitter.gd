extends Bonus

var splitter_scene: PackedScene = load("res://splitter.tscn")

func set_sprite():
	$Bonus/Sprite2D.set_texture(load("res://art/weapon_bonus.png"))


# Called when the node enters the scene tree for the first time.
func effect():
	var splitter = splitter_scene.instantiate()
	_player.add_child(splitter)
	splitter.position = Vector2(0, -40)
	
