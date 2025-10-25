extends Node

var passed_levels : Array = [1, 2, 5]

func _ready() -> void:
	pass

func _save():
	var config = ConfigFile.new()
	config.set_value("Level", "passed", passed_levels)
	config.save("user://config.cfg")
	print("saved")

func _load():
	var config = ConfigFile.new()
	var result = config.load("user://config.cfg")
	if(result == OK):
		passed_levels = config.get_value("Level", "passed")
		print(passed_levels)
