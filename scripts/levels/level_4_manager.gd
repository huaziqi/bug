extends LevelManager
@onready var zhang: RigidBody2D = $Zhang


func _on_dialogue_ended():
	super._on_dialogue_ended()
	if(zhang):
		MusicManager.stop_music()
		hide_item(zhang)
		zhang.queue_free()
