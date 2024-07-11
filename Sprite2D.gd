extends Node2D
@onready var _follow :PathFollow2D = get_parent()
var _speed :float = 60.0

func _physics_process(delta):
	_follow.set_progress(_follow.get_progress() + _speed * delta)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
