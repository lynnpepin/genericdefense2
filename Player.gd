extends CharacterBody3D

var speed = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector3.ZERO;
	
	if Input.is_action_pressed("key_a"):
		velocity.x = -1 * speed;
	if Input.is_action_pressed("key_w"):
		velocity.y =  1 * speed;
	if Input.is_action_pressed("key_d"):
		velocity.x =  1 * speed;
	if Input.is_action_pressed("key_s"):
		velocity.y = -1 * speed;
	
	move_and_slide()
	
	# no idea why z position gets changed when attached to player
