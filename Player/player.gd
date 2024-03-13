extends CharacterBody2D

var movement_speed = 100
var hp = 100

@onready var sprite_2d = $Sprite2D

func _ready():
	var move_direction = get
	sprite_2d.play("default")

func _physics_process(delta):
	movement()
	

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up")
	var mov = Vector2(x_mov, y_mov)
	velocity = mov.normalized()*movement_speed
	move_and_slide()
	
	if Input.is_action_just_pressed("up"):
		sprite_2d.play("walk_backward")
	if Input.is_action_just_pressed("down"):
		sprite_2d.play("walk_forward")
	if Input.is_action_just_pressed("left"):
		sprite_2d.play("walk_left")
	if Input.is_action_just_pressed("right"):
		sprite_2d.play("walk_right")


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
	if hp <= 0:
		queue_free()
