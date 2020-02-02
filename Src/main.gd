extends Node

##-------------------------
#
# 	Main Game loop
#
##-------------------------
var showing_opt = false
var showing_opt_dir = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("ui_up"):
		if showing_opt:
			if showing_opt_dir == "up":
				$Player.try_enter("up") #else ignore input
			elif showing_opt_dir == "down":
				retract_option("down")
		else: show_option("up")
	elif event.is_action_pressed("ui_down"):
		if showing_opt:
			if showing_opt_dir == "down":
				$Player.try_enter("down") #else ignore input
			elif showing_opt_dir == "up":
				retract_option("up")
		else: show_option("down")
	elif event.is_action_pressed("ui_left"):
		if showing_opt:
			if showing_opt_dir == "left":
				$Player.try_enter("left") #else ignore input
			elif showing_opt_dir == "right":
				retract_option("right")
		else: show_option("left")
	elif event.is_action_pressed("ui_right"):
		if showing_opt:
			if showing_opt_dir == "right":
				$Player.try_enter("right") #else ignore input
			elif showing_opt_dir == "left":
				retract_option("left")
		else: show_option("right")
	elif event is InputEventKey:
        if event.pressed and event.scancode == KEY_ESCAPE:
            get_tree().quit()

func show_option(dir):
	var text = $Player.peek(dir)
	if dir == "up":
		$Up/upopt.text = text
	elif dir == "down":
		$Down/downopt.text = text
	elif dir == "left":
		$Left/leftopt.text = text
	elif dir=="right":
		$Right/rightopt.text = text
	showing_opt = true
	showing_opt_dir = dir
	$AnimationPlayer.play(dir)
	
func retract_option(dir):
	$AnimationPlayer.play(dir+"_r")
	showing_opt = false
	showing_opt_dir = ""
	
func try_enter(dir):
	var add
	if dir == "up":
		add = $Player.current_room().up[1]
	elif dir == "down":
		add = $Player.current_room().down[1]
	elif dir == "left":
		add = $Player.current_room().left[1]
	elif dir=="right":
		add = $Player.current_room().right[1]
	$Map/Map.create_room(add)
	
	