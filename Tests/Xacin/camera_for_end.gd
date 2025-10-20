extends Camera2D

# 震动参数（可直接修改数值调整）
var shake_strength: float = 1.2  # 震动幅度（越大越明显）
var shaking:bool=false

func _process(_delta: float):
	if shaking==true:
		var offs = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake_strength
		global_position += offs
