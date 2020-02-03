extends Node

##-------------------------
#
# 	Main Game loop
#
##-------------------------
var showing_opt = false
var showing_opt_dir = ""
var star_counter = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("new_entry",self,"new_entry")
	$Player.connect("collect_star",self,"on_collect_star")
	$Player.connect("game_over",self,"on_game_over")
	$Map/Map.create_room($Player.in_room)
	
	$Player.set_keydict($Map/Map.Dialogue_Line_Num)
	$Map/Map.Rooms[str($Player.in_room)].on_enter($Player)
	new_entry()

func on_collect_star():
	var list = [$Charm/Charm_sprite/Sprite1,$Charm/Charm_sprite/Sprite2,$Charm/Charm_sprite/Sprite3,$Charm/Charm_sprite/Sprite4]
	list[star_counter].show()
	star_counter += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("ui_up"):
		if showing_opt:
			if showing_opt_dir == "up":
				try_enter("up") #else ignore input
			elif showing_opt_dir == "down":
				retract_option("down")
		else: show_option("up")
	elif event.is_action_pressed("ui_down"):
		if showing_opt:
			if showing_opt_dir == "down":
				try_enter("down") #else ignore input
			elif showing_opt_dir == "up":
				retract_option("up")
		else: show_option("down")
	elif event.is_action_pressed("ui_left"):
		if showing_opt:
			if showing_opt_dir == "left":
				try_enter("left") #else ignore input
			elif showing_opt_dir == "right":
				retract_option("right")
		else: show_option("left")
	elif event.is_action_pressed("ui_right"):
		if showing_opt:
			if showing_opt_dir == "right":
				try_enter("right") #else ignore input
			elif showing_opt_dir == "left":
				retract_option("left")
		else: show_option("right")
	
	elif event.is_action_pressed("ui_home"):
		if showing_opt:
			if showing_opt_dir == "home":
				try_enter("home")
		else: 
			if $Player.keys["4"]:
				print("pressed home")
				show_option("home")
	elif event.is_action_pressed("ui_end"):
		if showing_opt:
			if showing_opt_dir == "home":
				retract_option("home")
	elif event is InputEventKey:
        if event.pressed and event.scancode == KEY_ESCAPE:
            get_tree().quit()
			

func new_entry():
	$DialogueBox/Dialogue.text = $Player.current_room($Map/Map).dialogue()
	$Patience.text = str($Player.p)
	($SFX_choice as AudioStreamPlayer).play(0)

func show_dialogue(string):
	$DialogueBox/Dialogue.text = string
	
func on_game_over():
	show_dialogue("... Thank you father, I... I'm sorry I must go. Maybe one day I will understand.")
	$Down/downopt.text = "May God be with you, my daughter... (She left) "
	showing_opt = true
	showing_opt_dir = "down"
	$AnimationPlayer.play("down")
	
	#fade out
#
#	get_tree().quit()
	

func show_option(dir):
	var text = $Player.peek(dir,$Map/Map)
	if dir == "up":
		$Up/upopt.text = text
	elif dir == "down":
		$Down/downopt.text = text
	elif dir == "left":
		$Left/leftopt.text = text
	elif dir=="right":
		$Right/rightopt.text = text
	elif dir=="home":
		text = "(Go back to the beginning.)"
	if text == "":
		return 
	showing_opt = true
	showing_opt_dir = dir
	$AnimationPlayer.play(dir)
	
func retract_option(dir):
	$AnimationPlayer.play(dir+"_r")
	showing_opt = false
	showing_opt_dir = ""
	
func try_enter(dir):
	var id
	if dir == "up":
		id = $Player.current_room($Map/Map).up[1]
	elif dir == "down":
		id = $Player.current_room($Map/Map).down[1]
	elif dir == "left":
		id = $Player.current_room($Map/Map).left[1]
	elif dir=="right":
		id = $Player.current_room($Map/Map).right[1]
	elif dir=="home":
		id = 4
	if id != 0:
		$Map/Map.create_room(id)
		$Map/Map.Rooms[str(id)].on_enter($Player)
		print($Map/Map.Rooms[str(id)].Entered)
		if showing_opt:
			retract_option(dir)
	