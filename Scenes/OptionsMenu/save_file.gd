extends Resource
class_name SaveFile
#1. var save_file: SaveFile 				//located at the top of the script
#2. save_file = SaveFile.load_or_create()	//located in func _ready()
#3 	save_file.rsDict = Global.rsDict		//Update exported variable to new value - Place in signal, not process delta
#   save_file.save()						//Save changes
@export var rsDict: Dictionary
@export var rsPoints: int
func save() -> void:
	ResourceSaver.save(self, "user://player_save.tres")

static func load_or_create() -> SaveFile:
	var res: SaveFile = load("user://player_save.tres") as SaveFile
	if !res:
		res = SaveFile.new()
	return res
