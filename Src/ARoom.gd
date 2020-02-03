extends Node

class_name Room

var ID : int
var Dialogue : String
var PCost : int
var Need_key: Array  ## What room you need to explore to be able to enter this room.
var Give_key: bool
var up :Array   # [String, id]
var down:Array
var left:Array
var right:Array

var Entered = false   # if it's the first time player entering the room

signal collect_star
signal entry_denied

func init(id, dialogue, pcost, needkey, givekey, options):
	ID = int(id)
	Dialogue = str(dialogue)
	PCost = int(pcost)
	Need_key = needkey.split(" ")
	Give_key = bool(givekey)
	up = [options[0][1],int(options[0][0])]
	down = [options[1][1],int(options[1][0])]
	left = [options[2][1],int(options[2][0])]
	right = [options[3][1],int(options[3][0])]
	
func dialogue():
	return Dialogue

func on_enter(player):
	if !player.has_key(Need_key):
		print(Need_key, player.keys)
		print("entry denied.")
		emit_signal("entry_denied")
		return [false, player.currentRoom]
	#if !Entered:
	player.lose_p(ID, PCost)
	print(Entered)
	player.move_to(ID,self)
	Entered = true
#	if Give_key:
	player.get_key(ID)
	return [true, self]#return the room you are currently in.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
