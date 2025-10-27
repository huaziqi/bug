extends Node

var access_levels : Dictionary = {}

func _ready() -> void:
	Config._load()
	access_levels = Config.access_levels

func _save():
	var config = ConfigFile.new()
	config.set_value("Level", "access", access_levels)
	config.save("user://config.cfg")
	print("saved")

func _load():
	var config = ConfigFile.new()
	var result = config.load("user://config.cfg")
	if(result == OK):
		access_levels = config.get_value("Level", "access")
		print(access_levels)
