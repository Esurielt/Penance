extends Node

class_name Map
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var DialogueList_f  # vector4

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("user://save_game.dat", File.READ)
	
	
func create_room(id):
	pass
	
func load_dialogueList():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
