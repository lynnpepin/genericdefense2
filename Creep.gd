extends Node2D
@onready var _follow :PathFollow2D = get_parent()
var _speed :float = 64.0

var MAX_HEALTH = 128.0;
var HEALTH     = 128.0;
var VALUE      =  3.0;
var DAMAGE     =  4.0;

func _physics_process(delta):
	_follow.set_progress(_follow.get_progress() + _speed * delta)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.add_to_group("creep")
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#HEALTH -= delta
	if _follow.progress_ratio >= 1.0:
		get_tree().current_scene.set_health(-DAMAGE)
		queue_free()
		
	queue_redraw()
	pass

func damage(value):
	HEALTH -= value
	if HEALTH <= 0:
		get_tree().current_scene.set_money(VALUE)
		queue_free()


func _draw():
	draw_line(
		self.transform.x + Vector2(18, -8),
		self.transform.x + Vector2(18, 8),
		Color(1.0, 0.0, 0.0),
		2.0
	)
	
	draw_line(
		self.transform.x + Vector2(18, -8),
		self.transform.x + Vector2(18, -8 + 16 * HEALTH / MAX_HEALTH),
		Color(0.0, 1.0, 0.0),
		2.0
	)

