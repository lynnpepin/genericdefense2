extends Node2D


var creep_scene = preload("res://creep.tscn")

var timer = 0.0

var wave = [
	{ "speed" : 32.0, "health" : 1, "value" : 1, "damage" : 1, "period" : 1.0 },
	{ "speed" : 32.0, "health" : 1, "value" : 1, "damage" : 1, "period" : 1.0 },
	{ "speed" : 32.0, "health" : 1, "value" : 1, "damage" : 1, "period" : 1.0 },
	{ "speed" : 32.0, "health" : 1, "value" : 1, "damage" : 1, "period" : 1.0 },
	{ "speed" : 32.0, "health" : 1, "value" : 1, "damage" : 1, "period" : 1.0 },
	{ "speed" : 32.0, "health" : 1, "value" : 1, "damage" : 1, "period" : 1.0 },
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(wave) > 0:
		if timer <= 0.0:
			print("... Spawning creep!")
			var creep_deets = wave.pop_front()
			var creep = creep_scene.instantiate()
			creep.SPEED  = creep_deets.speed
			creep.HEALTH = creep_deets.health
			creep.VALUE  = creep_deets.value
			creep.DAMAGE = creep_deets.damage
			$CreepPath/PathFollow2D.add_child(creep)
			
			timer = creep_deets.period
		else:
			timer -= delta
	
	queue_redraw()

func _draw():
	draw_circle(Vector2(0,0), 4, Color(1, 1, 1))

