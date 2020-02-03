extends Node

class_name Map
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mapbox = preload("res://UI/mapbox.tscn")
export var Dialogue_Line_Num = 227
export var Map_Row_Num = 50
export var Map_Col_Num = 50

export var Star_Room_Num = [0,0,0,0]
onready var DialogueKeys = ["ID","Dialogue","Cost","LockBy","b_Unlock","UpId","UpOpt","DownId","DownOpt","LeftId","LeftOpt","RightId","RightOpt"] 
var DialogueList = []  # list of dialogue dicts
var Rooms = {} # dictionary of created rooms
var MapShape = []

signal new_room

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialogueList()
	# load_mapshape()
	
func create_room(id):
	var roomdict = DialogueList[id] #-1]
	print(roomdict["ID"], roomdict["Dialogue"])
	var newRoom = Room.new()
	var options = [[roomdict["UpId"],roomdict["UpOpt"]],[roomdict["DownId"],roomdict["DownOpt"]],[roomdict["LeftId"],roomdict["LeftOpt"]],[roomdict["RightId"],roomdict["RightOpt"]]]
	newRoom.init(roomdict["ID"], roomdict["Dialogue"], roomdict["Cost"], roomdict["LockBy"], roomdict["b_Unlock"], options)
	Rooms[roomdict["ID"]] = newRoom
	return Rooms[roomdict["ID"]]
	
func enter_room(id):
	Rooms[str(id)].Entered = false
	
func spawn_mapbox(player,dir):
	# it takes the player's position, and a direction(string) and spawn a mapbox instance in that direction.
	# assuming that there actually is a room there.
	var position = player.get_postion()  # Vector2 as row,col
	var dir_v = {"up":[-1,0], "down":[1,0],"left":[0,-1],"right":[0,1]}[dir]
	position += dir_v
	var newbox = mapbox.instance()
	newbox.position = Vector2(position[0]*32,position[1]*32)
	add_child(newbox)
	emit_signal("new_room")
	
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
	for i in range(Dialogue_Line_Num+1):
		var newDict = {}
		var a = file.get_csv_line()
		for i in range(len(DialogueKeys)):
			newDict[DialogueKeys[i]] =  a[i]
		DialogueList.append(newDict)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
