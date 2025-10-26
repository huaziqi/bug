extends Camera2D

@export var is_shaking = false
@export var shake_time=0 # 抖动持续时间
@export var shake_strength=0# 抖动幅度
@export var pos=Vector2(570,328)
@export var aberration:float=0.02
@export var roll:bool=false
@export var roll_size:float=0
func _ready() -> void:
	position=pos
	$ColorRect.material.set_shader_parameter("aberration", aberration)
	$ColorRect.material.set_shader_parameter("roll", roll)
	$ColorRect.material.set_shader_parameter("roll_size", roll_size)
func _process(delta):
	if is_shaking:
		# 随机偏移位置实现抖动
		position = Vector2(
			randf_range(pos.x-shake_strength, pos.x+shake_strength),
			randf_range(pos.y-shake_strength, pos.y+shake_strength)
		)
		shake_time -= delta
		if shake_time <= 0:
			is_shaking = false
			position=pos

# 调用这个函数触发抖动
func shake(s,t):
	if not is_shaking:
		pos=position
	is_shaking = true
	shake_time = t  
	shake_strength = s
	
