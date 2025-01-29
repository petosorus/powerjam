extends Node

@export var mob_scene: PackedScene
@export var bonus_scene: PackedScene
@export var weapon_scene: PackedScene

enum Orientations { TOP, BOTTOM, RIGHT, LEFT }

var game_speed = 1
@export var path_orientation: Orientations = Orientations.TOP
var bonuses = {
	"weapons": [
		"res://bonus/splitter.gd",
	],
	"ship_size": [
		"res://bonus/ship_size/big.gd",
		"res://bonus/ship_size/normal.gd",
		"res://bonus/ship_size/small.gd",
	],
	"game_speed": [
		"res://bonus/game_speed/slow.gd",
		"res://bonus/game_speed/fast.gd",
		"res://bonus/game_speed/normal.gd",
	],
	"ship_speed": [
		"res://bonus/ship_speed/slow.gd",
		"res://bonus/ship_speed/fast.gd",
		"res://bonus/ship_speed/normal.gd",
	],
	"orientations": [
		"res://bonus/orientation/top.gd",
		"res://bonus/orientation/bottom.gd",
		"res://bonus/orientation/left.gd",
		"res://bonus/orientation/right.gd",
	]
}

var current_bonuses = {
	"weapons": "res://bonus/splitter.gd",
	"ship_size": "res://bonus/ship_size/normal.gd",
	"game_speed": "res://bonus/game_speed/normal.gd",
	"ship_speed": "res://bonus/ship_speed/normal.gd",
	"orientations": "res://bonus/orientation/top.gd"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start($StartPosition.position)
	$WeaponTimer.start()
	$BonusTimer.start()
	$MobTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	pass
	#$ScoreTimer.stop()
	#$MobTimer.stop()
	#
	#$HUD.show_game_over()

func new_game():
	pass
	#$Player.start($StartPosition.position)
	#$StartTimer.start()
	#
	#$HUD.update_score(score)
	#$HUD.show_message("Get ready")
	#
	#get_tree().call_group("mobs", "queue_free")

func update_game_speed(speed):
	Engine.time_scale = speed

func top():
	path_orientation = Orientations.TOP
	
func bottom():
	path_orientation = Orientations.BOTTOM
	
func left():
	path_orientation = Orientations.LEFT
	
func right():
	path_orientation = Orientations.RIGHT

func _new_path():
	var path = Path2D.new()
	var curve = Curve2D.new()
	path.set_curve(curve)
	
	var width = get_viewport().get_visible_rect().size[0]
	var height = get_viewport().get_visible_rect().size[1]
	
	if path_orientation in [Orientations.TOP, Orientations.BOTTOM]:
		var position = randi_range(0, width)
		
		if path_orientation == Orientations.TOP:
			path.curve.add_point(Vector2(position, 0))
			path.curve.add_point(Vector2(position, height))
		if path_orientation == Orientations.BOTTOM:
			path.curve.add_point(Vector2(position, height))
			path.curve.add_point(Vector2(position, 0))
	if path_orientation in [Orientations.RIGHT, Orientations.LEFT]:
		var position = randi_range(0, height)
		if path_orientation == Orientations.LEFT:
			path.curve.add_point(Vector2(0, position))
			path.curve.add_point(Vector2(width, position))
		if path_orientation == Orientations.RIGHT:
			path.curve.add_point(Vector2(width, position))
			path.curve.add_point(Vector2(0, position))
	
	return path

func _on_bonus_timer_timeout() -> void:
	var bonus: Bonus = bonus_scene.instantiate()
	var random_category = bonuses.keys()[randi_range(0, bonuses.size() - 1)]
	var random_bonus = bonuses.get(random_category).pick_random()
		
	while current_bonuses.get(random_category) == random_bonus:
		random_category = bonuses.keys()[randi_range(0, bonuses.size() - 1)]
		random_bonus = bonuses.get(random_category).pick_random()
		
	bonus.set_script(load(random_bonus))
	bonus.set_player($Player)
	bonus.category = random_category
	bonus.bonus = random_bonus
	
	var path = _new_path()
	path.add_child(bonus)
	add_child(path)
	

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var path = _new_path()
	path.add_child(mob)
	add_child(path)


func _on_weapon_timer_timeout() -> void:
	var weapon = weapon_scene.instantiate()
	
	var path = Path2D.new()
	var curve = Curve2D.new()
	path.set_curve(curve)
	
	var width = get_viewport().get_visible_rect().size[0]
	var height = get_viewport().get_visible_rect().size[1]
	
	path.curve.add_point(Vector2($Player.position))
	path.curve.add_point(Vector2($Player.position[0], 0))
	path.add_child(weapon)
	
	#print("Player:", $Player.position, "Weapon: ", path.curve.get_point_position(0), path.curve.get_point_position(1))
	add_child(path)
