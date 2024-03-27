extends CharacterBody2D

var movement_speed = 200
@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.play("default")

func _physics_process(_delta):
	movement()
	

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up")
	var mov = Vector2(x_mov, y_mov)
	
	if Input.is_action_just_pressed("up"):
		sprite_2d.play("walk_backward")
	if Input.is_action_just_pressed("down"):
		sprite_2d.play("walk_forward")
	if Input.is_action_just_pressed("left"):
		sprite_2d.play("walk_left")
	if Input.is_action_just_pressed("right"):
		sprite_2d.play("walk_right")
	
	velocity = mov.normalized()*movement_speed
	move_and_slide()
	
	
