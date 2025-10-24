extends PanelContainer
@onready var cursor = $input/MarginContainer/cursor_flicker        # ColorRect 节点
@onready var cursor_timer =$input/MarginContainer/cursor_flicker/Timer  # Timer 节点
@onready var player_label=$input/Label_player	

func _ready() -> void:
	cursor_timer.timeout.connect(_on_timer_timeout)
	show_cursor()

#以下都是光标相关
func _on_cursor_timer_timeout():
	# 每次超时，就切换光标的 visible 属性
	# 如果当前可见，就设为不可见；如果当前不可见，就设为可见。
	cursor.visible = not cursor.visible
	
func hide_cursor():
	cursor_timer.stop() # 停止计时器
	cursor.visible = false # 确保它处于隐藏状态
	
	
func show_cursor():
	cursor_timer.start() # 重新启动计时器
	cursor.visible = true # 确保开始时是可见的



func _on_timer_timeout() -> void:
	cursor.visible = not cursor.visible
