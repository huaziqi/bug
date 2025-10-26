extends PanelContainer
@onready var label_content=$loading_content
@onready var root_panel=$"."
var time_change_count_para=0
const Loading_lines=["1","2","3"]
var new_label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var first_label=label_content.text
	GameState.loading_process_signal.connect(change_label)
	
	
func change_label(time_change_count):
	#time_change_count_para+=1
	if time_change_count<Loading_lines.size():
		print(0)
		label_content.text+=Loading_lines[time_change_count]
	 



	
	
	
