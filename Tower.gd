extends Node2D

var RADIUS = 128;
var FIRE_PERIOD = 2.0;
var FIRE_TIMER  = 2.0;

# Variables for handling mouse events
var mouse_area_inside = false;
# Called when the node enters the scene tree for the first time.

func _ready():
	$AttackArea/CollisionShape2D.shape.radius = RADIUS;
	$TowerArea.connect("mouse_entered", _on_mouse_entered)
	$TowerArea.connect("mouse_exited", _on_mouse_exited)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Handle fire timer
	if FIRE_TIMER >= FIRE_PERIOD:
		# can fire
		FIRE_TIMER = 0#FIRE_PERIOD
		pass
	else:
		# can' fire, increase time
		FIRE_TIMER += delta
	
	# Render fire timer
	$Sprite2D.modulate = Color(1.0, FIRE_TIMER / FIRE_PERIOD, FIRE_TIMER / FIRE_PERIOD)
	
	# Call draw func
	queue_redraw()
	
	

func _draw():
	if mouse_area_inside:
		draw_arc(
			self.transform.y,
			float(RADIUS),
			0,
			2 * PI,
			121,
			Color(.875, 0.625, 0.125),
			2.0
		)
		draw_arc(
			self.transform.y,
			float(RADIUS),
			PI,
			PI + 2 * PI * (FIRE_TIMER / FIRE_PERIOD),
			121,
			Color(1.0, 0.75, 0.125),
			2.0
		)

# Signal handler for mouse entered
func _on_mouse_entered():
	print("Mouse has entered")
	mouse_area_inside = true

# Signal handler for mouse exited
func _on_mouse_exited():
	print("Mouse has exited")
	mouse_area_inside = false

