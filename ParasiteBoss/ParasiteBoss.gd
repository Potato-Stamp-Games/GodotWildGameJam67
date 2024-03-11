extends CharacterBody2D

@export var movement_speed = 40.0
@export var hp = 500
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	$Sprite2D.play("new_animation")
	

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*movement_speed
	move_and_slide()
