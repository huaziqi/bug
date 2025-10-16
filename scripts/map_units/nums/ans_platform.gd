extends StaticBody2D

@export var ans_label : Label
@export var collision_area: CollisionShape2D
@export var checker_area: CollisionShape2D

func _ready():
	pass
	
	
func _physics_process(delta: float) -> void:
	update_layout()

func update_layout():
	if ans_label == null:
		return

	# 计算文字宽度
	var text_width = ans_label.get_minimum_size().x
	#print(text_width)
	# 设置 label 宽度
	#ans_label.size.x = text_width

	# 同步调整碰撞区域宽度
	set_collision_width_keep_left(collision_area, text_width)
	set_collision_width_keep_left(checker_area, text_width)

func set_collision_width_keep_left(area: CollisionShape2D, new_width: float):
	if area == null:
		return

	var shape = area.shape
	if shape is RectangleShape2D:
		var old_width = shape.size.x
		var old_left = area.position.x - old_width / 2.0
		shape.size.x = new_width
		area.position.x = old_left + new_width / 2.0
