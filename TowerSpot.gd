extends Node2D

var mouse_area_inside = false
var default_font : Font = ThemeDB.fallback_font
signal area_clicked(position)
var tower_scene = preload("res://tower.tscn")

@export var COST = 16;


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("mouse_entered", _on_mouse_entered)
	$Area2D.connect("mouse_exited", _on_mouse_exited)
	$Area2D.connect("input_event", _on_Area2D_input_event)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

# Signal handler for mouse entered
func _on_mouse_entered():
	mouse_area_inside = true

# Signal handler for mouse exited
func _on_mouse_exited():
	mouse_area_inside = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	# Check if the event is a mouse button event and the button is pressed
	if event is InputEventMouseButton and event.pressed:
		# Emit a signal or perform an action
		#emit_signal("area_clicked", event.position)
		#print("Mouse clicked inside Area2D at:", event.position)
		var total_money = get_tree().current_scene.MONEY
		if total_money >= COST:
			get_tree().current_scene.set_money(-COST)
			replace_instance(self, tower_scene)


func replace_instance(old_instance, new_scene):
	var new_instance = new_scene.instantiate()
	new_instance.position = old_instance.position + Vector2(8,8)  # Copy the position
	new_instance.rotation = old_instance.rotation  # Copy rotation if necessary
	old_instance.get_parent().add_child(new_instance)  # Add new instance to the same parent
	old_instance.queue_free()  # Remove the old instance



func _draw():
	if mouse_area_inside:
		# Draw frame
		draw_rect(Rect2(Vector2(0,0), Vector2(16,16)), Color(1.0, 1.0, 1.0, .5), false, 1)
		draw_rect(Rect2(Vector2(0,0), Vector2(16,16)), Color(1.0, 1.0, 1.0, .25), true, 1)
		
		# CHEAP dropshadow
		draw_string(default_font, Vector2(0, 25), "-%d" % COST, 0, -1, 12, Color(0.0, 0.0, 0.0, 0.25))
		draw_string(default_font, Vector2(1, 24), "-%d" % COST, 0, -1, 12, Color(0.0, 0.0, 0.0, 0.25))
		draw_string(default_font, Vector2(1, 25), "-%d" % COST, 0, -1, 12, Color(0.0, 0.0, 0.0, 0.25))
		draw_string(default_font, Vector2(0, 24), "-%d" % COST, 0, -1, 12, Color(1.0, 0.50, 0.25))
