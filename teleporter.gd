extends AnimatedSprite2D

@onready var buttons = $LevelButtonLayer/Buttons
@onready var poison_button = $LevelButtonLayer/Buttons/PoisonBtn
@onready var fire_button = $LevelButtonLayer/Buttons/FireBtn
@onready var ice_button = $LevelButtonLayer/Buttons/IceBtn

@onready var teleporter = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	buttons.visible = true

func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	buttons.visible = false

func _on_ice_btn_pressed():
	teleporter.play("default")

func _on_fire_btn_pressed():
	pass
	

func _on_poison_btn_pressed():
	pass # Replace with function body.

func _on_area_2d_body_entered(body):
	buttons.visible = true

func _on_area_2d_body_exited(body):
	buttons.visible = false
