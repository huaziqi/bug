extends Node2D
@onready var bo: AudioStreamPlayer2D = $Flag/bo
signal end_back_to_main1
#被尘封的代码
#把背景框调成透明
#func per_pixel_transparency():
	#ProjectSettings.set_setting("display/window/per_pixel_transparency/allowed",true)
##显示-窗口-像素级透明
	#ProjectSettings.set_setting("display/window/size/transparent",true)
##显示-窗口-透明
	#ProjectSettings.set_setting("rendering/viewport/transparent_background",true)
##渲染-视口-透明背景
#func _ready() -> void:
	#per_pixel_transparency()
	#print(ProjectSettings.get_setting("display/window/per_pixel_transparency/allowed"))
	#print(ProjectSettings.get_setting("display/window/size/transparent"))
	#print(ProjectSettings.get_setting("rendering/viewport/transparent_background"))
func get_back_to_main():
	get_tree().change_scene_to_file("res://src/Scene/main.tscn")


func _on_flag_flag_up() -> void:
	get_back_to_main()
	end_back_to_main1.emit()
