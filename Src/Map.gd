extends Node

class_name Map
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mapbox = preload("res://UI/mapbox.tscn")
export var Dialogue_Line_Num = 5
export var Map_Row_Num = 50
export var Map_Col_Num = 50
onready var DialogueKeys = ["ID","Dialogue","Cost","LockBy","b_Unlock","UpId","UpOpt","DownId","DownOpt","LeftId","LeftOpt","RightId","RightOpt"] 
var DialogueList = []  # list of dialogue dicts
var Rooms = [] # dictionary of created rooms
var MapShape = []

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialogueList()
	
func create_room(id):
	var roomdict = DialogueList[id-1]
	
	
func load_mapshape():
	var file = File.new()
	file.open("res://Src/MapShape.csv", File.READ)
	for i in range(Map_Row_Num):
		var row = []
		for i in range(Map_Col_Num):
			row.append(file.get_csv_line())
		MapShape.append(row)
	
func load_dialogueList():
	var file = File.new()
	file.open("res://Src/P_DialogueList.csv", File.READ)
	for i in range(Dialogue_Line_Num):
		var newDict = {}
		for i in range(len(DialogueKeys)):
			newDict[DialogueKeys[i]] = file.get_csv_line()
		DialogueList.append(newDict)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
