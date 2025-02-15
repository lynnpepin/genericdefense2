extends Node2D


var creep_scene = preload("res://creep.tscn")

var timer = 0.0

var wave = [
	{ "speed" : 128.0, "health" :  4, "value" : 3, "damage" : 1, "period" : 2.0 },
	{ "speed" : 24.0, "health" :  4, "value" : 3, "damage" : 1, "period" : 2.0 },
	{ "speed" : 24.0, "health" :  4, "value" : 3, "damage" : 1, "period" : 2.0 },
	{ "speed" : 24.0, "health" :  4, "value" : 3, "damage" : 1, "period" : 6.0 },
	{ "speed" : 64.0, "health" :  1, "value" : 1, "damage" : 1, "period" : 0.25 },
	{ "speed" : 64.0, "health" :  1, "value" : 1, "damage" : 1, "period" : 0.25 },
	{ "speed" : 64.0, "health" :  1, "value" : 1, "damage" : 1, "period" : 0.25 },
	{ "speed" : 64.0, "health" :  1, "value" : 1, "damage" : 1, "period" : 0.25 },
	{ "speed" : 64.0, "health" :  1, "value" : 1, "damage" : 1, "period" : 0.25 },
	{ "speed" : 64.0, "health" :  1, "value" : 1, "damage" : 1, "period" : 0.25 },
	{ "speed" : 64.0, "health" :  1, "value" : 1, "damage" : 1, "period" : 6.0 },
	{ "speed" : 12.0, "health" : 15, "value" : 6, "damage" : 1, "period" : 1.0 },
	{ "speed" : 24.0, "health" : 15, "value" : 8, "damage" : 1, "period" : 1.0 },
	{ "speed" : 24.0, "health" : 16, "value" : 8, "damage" : 1, "period" : 1.0 },
	{ "speed" : 24.0, "health" : 16, "value" : 8, "damage" : 1, "period" : 1.0 },
	{ "speed" : 24.0, "health" : 16, "value" : 8, "damage" : 1, "period" : 1.0 },
	{ "speed" : 24.0, "health" : 20, "value" : 8, "damage" : 1, "period" : 1.0 },
	{ "speed" : 24.0, "health" : 20, "value" : 8, "damage" : 1, "period" : 1.0 },
	{ "speed" : 24.0, "health" : 20, "value" : 8, "damage" : 1, "period" : 1.0 },
	{ "speed" : 24.0, "health" : 24, "value" : 8, "damage" : 1, "period" : 1.0 },
	{ "speed" : 24.0, "health" : 24, "value" : 8, "damage" : 1, "period" : 1.0 },
	{ "speed" : 24.0, "health" : 24, "value" : 8, "damage" : 1, "period" : 1.0 },
	{ "speed" : 48.0, "health" : 30, "value" : 12, "damage" : 1, "period" : 4.0 },
	{ "speed" : 48.0, "health" : 30, "value" : 12, "damage" : 1, "period" : 8.0 },
	{ "speed" : 48.0, "health" : 30, "value" : 12, "damage" : 1, "period" : 8.0 },
	{ "speed" : 48.0, "health" : 30, "value" : 12, "damage" : 1, "period" : 8.0 },
	{ "speed" : 48.0, "health" : 30, "value" : 12, "damage" : 1, "period" : 8.0 },
	{ "speed" : 24.0, "health" : 32, "value" : 1600, "damage" : 1, "period" : 12.0 },
	{ "speed" : 8.0, "health" : 1024, "value" : 8, "damage" : 1, "period" : 1.0 },
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
			creep.MAX_HEALTH = creep_deets.health
			creep.VALUE  = creep_deets.value
			creep.DAMAGE = creep_deets.damage
			$CreepPath.add_child(creep)
			timer = creep_deets.period
		else:
			timer -= delta
	
	queue_redraw()

func _draw():
	draw_circle(Vector2(0,0), 48, Color(1, 1, 1, 0.125))

