extends PathFollow2D

class_name Bonus

var _player
var category: String
var bonus: String

const _speed = 100

func set_player(player):
	_player = player

func set_sprite():
	print("no effect on base class")

func effect():
	print("no effect on base class")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var newProgress = self.get_progress() + _speed * delta
	var pathLength = get_parent().curve.get_baked_length()
	if (newProgress >= pathLength):
		delete()
	self.set_progress(newProgress)
	

func delete():
	get_parent().queue_free()
	queue_free()

func _on_bonus_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		get_parent().get_parent().current_bonuses.erase(category)
		get_parent().get_parent().current_bonuses.get_or_add(category, bonus)
		effect()
		queue_free()
