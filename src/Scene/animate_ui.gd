extends PanelContainer
# 附在你的 Control/TextureButton 上（Godot 4）

func _ready():
	# 等一帧，确保 size 已计算完成
	await get_tree().process_frame
	pivot_offset = size / 2
	scale = Vector2.ZERO
	#modulate.a = 0.0 
	animate_in()

func animate_in():
	var tw = create_tween()
	# 先弹到 1.05 再回到 1.0，营造“从中心展开”的动效
	tw.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tw.tween_property(self, "scale", Vector2(1.03, 1.03), 0.25)
	#tw.parallel().tween_property(self, "modulate:a", 1.0, 0.18)
	tw.tween_property(self, "scale", Vector2.ONE, 0.3)
