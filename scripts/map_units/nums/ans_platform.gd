extends StaticBody2D

@export var ans_label : Label
@export var collision_area: CollisionShape2D
@export var checker_area: CollisionShape2D
@onready var marker_2d: Marker2D = $"../../Marker2D"

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	update_layout()

func update_layout():
	if ans_label == null:
		return
	print(ans_label)

	var text_width = ans_label.get_minimum_size().x

	set_collision_width_keep_left(collision_area, text_width)
	set_collision_width_keep_left(checker_area, text_width)

func set_collision_width_keep_left(area: CollisionShape2D, new_width: float):
	
	if area == null or marker_2d == null:
		return

	var shape = area.shape
	if shape is RectangleShape2D:
		var left_x = marker_2d.position.x
		shape.size.x = new_width
		area.global_position.x = left_x + new_width / 2.0
