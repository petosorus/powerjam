extends Node

@export var mob_scene: PackedScene
@export var bonus_scene: PackedScene
@export var weapon_scene: PackedScene

var game_speed = 1
var bonuses = [
	"res://bonus/ship_size/big.gd",
	"res://bonus/ship_size/normal.gd",
	"res://bonus/ship_size/small.gd",
	"res://bonus/splitter.gd",
	"res://bonus/game_speed/game_slow.gd",
	"res://bonus/game_speed/game_fast.gd"
]

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

func _new_path():
	var path = Path2D.new()
	var curve = Curve2D.new()
	path.set_curve(curve)
	
	var width = get_viewport().get_visible_rect().size[0]
	var height = get_viewport().get_visible_rect().size[1]
	
	var position = randi_range(0, width)
	path.curve.add_point(Vector2(position, 0))
	path.curve.add_point(Vector2(position, height))
	
	return path

func _on_bonus_timer_timeout() -> void:
	var bonus = bonus_scene.instantiate()
	bonus.set_script(load(bonuses.pick_random()))
	bonus.set_player($Player)
	
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
