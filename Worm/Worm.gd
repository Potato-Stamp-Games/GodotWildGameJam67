extends CharacterBody2D

@export var movement_speed = 65.0
@export var hp = 40
@export var knockback_recovery = 3.5
@export var experience = 5
var knockback = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")

var EXPERIENCE_PAW = preload("res://Utility/experience_paw.tscn")
signal remove_from_array(object)

func _ready():
	$Sprite2D.play("new_animation")
	

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*movement_speed
	velocity += knockback
	move_and_slide()

func death():
	emit_signal("remove_from_array", self)
	var new_expPaw = EXPERIENCE_PAW.instantiate()
	new_expPaw.global_position = global_position
	new_expPaw.experience = experience
	loot_base.call_deferred("add_child", new_expPaw)
	queue_free()

func _on_hurt_box_hurt(damage, angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		emit_signal("remove_from_array", self)
		death()
