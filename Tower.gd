extends Node2D

var RADIUS = 64.0
var FIRE_PERIOD = 1.0
var FIRE_TIMER  = 1.0
var CREEPS_INSIDE = []
var DAMAGE      = 3.0

var FIRING          = false

# Variables for handling mouse events
var mouse_area_inside = false;
# Called when the node enters the scene tree for the first time.

func _ready():
	$AttackArea/CollisionShape2D.shape.radius = RADIUS;
	
	$TowerArea.connect("mouse_entered", _on_mouse_entered)
	$TowerArea.connect("mouse_exited", _on_mouse_exited)
	
	$AttackArea.connect("area_entered", _on_attack_area_entered)
	$AttackArea.connect("area_exited", _on_attack_area_exited)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Handle fire timer
	if FIRE_TIMER >= FIRE_PERIOD:
		# can fire
		if len(CREEPS_INSIDE) > 0:
			FIRING = true;
			FIRE_TIMER = 0.0
			var creep = CREEPS_INSIDE[0].get_parent()
			creep.damage(DAMAGE)
	else:
		FIRING = false
		# can' fire, increase time
		FIRE_TIMER += delta
	
	# Render fire timer
	$Sprite2D.modulate = Color(1.0, FIRE_TIMER / FIRE_PERIOD, FIRE_TIMER / FIRE_PERIOD)
	
	# Call draw func
	queue_redraw()
	
	

func _draw():
	if mouse_area_inside:
		draw_arc(
			Vector2(0,0),
			float(RADIUS),
			0,
			2 * PI,
			121,
			Color(0.75, 0.5, 0.0),
			2.0
		)
		draw_arc(
			Vector2(0,0),
			float(RADIUS),
			PI,
			PI + 2 * PI * (FIRE_TIMER / FIRE_PERIOD),
			121,
			Color(1.0, 0.75, 0.125),
			2.0
		)
	## draw fire line
	if len(CREEPS_INSIDE) > 0:
		draw_line(
			Vector2(0,0),
			CREEPS_INSIDE[0].get_parent().global_position - self.global_position,
			Color(1.0, 0.0625, 0.125, FIRE_TIMER / ( 2 * FIRE_PERIOD)), #fmod((FIRE_TIMER / FIRE_PERIOD) - 0.0625, 1)),
			3
		)
		draw_line(
			Vector2(0,0),
			CREEPS_INSIDE[0].get_parent().global_position - self.global_position,
			Color(1.0, 0, 0, 0.125 + FIRE_TIMER / FIRE_PERIOD), #fmod((FIRE_TIMER / FIRE_PERIOD) - 0.0625, 1)),
			1
		)

func _on_attack_area_entered(area):
	if area.is_in_group("creep"):
		CREEPS_INSIDE.append(area)
		print("A creep has entered the area. Total creeps: %d" % len(CREEPS_INSIDE))

func _on_attack_area_exited(area):
	if area.is_in_group("creep"):
		CREEPS_INSIDE.erase(area)
		print("A creep has entered the area. Total creeps: %d" % len(CREEPS_INSIDE))

# Signal handler for mouse entered
func _on_mouse_entered():
	print("Mouse has entered")
	mouse_area_inside = true

# Signal handler for mouse exited
func _on_mouse_exited():
	print("Mouse has exited")
	mouse_area_inside = false


