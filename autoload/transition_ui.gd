# Transition.gd  —— 作为 Autoload 单例挂载（名称：Transition）
extends CanvasLayer

var rect: ColorRect

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	layer = 127  # 拉到最上层（越大越靠前）
	_ensure_rect()

func _ensure_rect() -> void:
	if is_instance_valid(rect):
		return
	rect = ColorRect.new()
	rect.name = "BlackOverlay"
	rect.color = Color(0, 0, 0, 0)              # 透明黑
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(rect)
	# 关键：铺满屏幕（不用 top_level，避免锚点失效）
	rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	rect.offset_left = 0
	rect.offset_top = 0
	rect.offset_right = 0
	rect.offset_bottom = 0

func fade_to_black(duration: float = 0.2) -> void:
	_ensure_rect()
	await get_tree().process_frame        # 等一帧让它进树并拿到尺寸
	# 保险：再把尺寸设到可见区域
	rect.size = get_viewport().get_visible_rect().size
	var tw := get_tree().create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(rect, "color:a", 1.0, duration)
	await tw.finished
	rect.color.a = 1.0

func fade_from_black(duration: float = 0.2) -> void:
	if not is_instance_valid(rect):
		return
	var tw := get_tree().create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(rect, "color:a", 0.0, duration)
	await tw.finished
	rect.color.a = 0.0

# —— 可选：一键强制黑/强制白（调试用），确认覆盖层确实在最上层 ——
func debug_force_black() -> void:
	_ensure_rect()
	rect.color = Color(0, 0, 0, 1)
	rect.size = get_viewport().get_visible_rect().size
	push_warning("[Transition] force black. size=%s layer=%d" % [rect.size, layer])

func debug_force_clear() -> void:
	if is_instance_valid(rect):
		rect.color.a = 0.0
