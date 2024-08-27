extends Node2D
@onready var hours = 23;
@onready var minutes = 59;
@onready var seconds = 59;
@onready var label;
@onready var notShader;
@onready var notBox;
@onready var interactables;
var firstCycle = true;
var oneShots1 = true;


	
func _doDialogue(words, time = 2):
	var diaLabel = notBox.get_node("Dialogue");
	diaLabel.text = words;
	notBox.visible = true;
	var diaTimer = notBox.get_node("fadeTimer");
	diaTimer.stop();
	diaTimer.start(time);
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	label =  get_node("%TimerLabel");
	notShader = get_node("UILayer/ScreenTint");
	notBox = get_node("UILayer/TextBG");
	interactables = get_tree().get_nodes_in_group("interact");
	for interaction in interactables:
		#the one fucking thing phaser sucks way less at
		interaction.touch.connect(_doDialogue.bind(interaction.get_meta("words"))); #im gonna kill myself this is so fucking obtuse
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_time_timeout():
	if Global.mode == "normal":
		seconds -= 1;
		get_node("Time").wait_time = 1;
	else:
		get_node("Time").wait_time = 0.001;
		seconds = -1;
	if seconds < 0:
		if hours < 24 and hours > 19:
			notShader.color.a -= notShader.get_meta("morning").a / 300;
		if hours == 19 and minutes == 59:
			notShader.color = notShader.get_meta("Night");
			notShader.color.a = 0;
		if hours < 15 and hours > 10:
			notShader.color.a += notShader.get_meta("Night").a / 300;
		if hours < 3 and hours > -1: # course of 3 hours = 180
			notShader.color.r += (notShader.get_meta("morning").r - notShader.get_meta("Night").r) / 180;
			notShader.color.b += (notShader.get_meta("morning").b - notShader.get_meta("Night").b) / 180;
			notShader.color.g += (notShader.get_meta("morning").g - notShader.get_meta("Night").g) / 180;
			notShader.color.a += (notShader.get_meta("morning").a - notShader.get_meta("Night").a) / 240;
		minutes -= 1;
		seconds = 59;
	if minutes < 0:
		hours -= 1;
		minutes = 59;
	if hours < 0:
		hours = 23;
		minutes = 59;
		seconds = 59;
		notShader.color = notShader.get_meta("morning");
		notShader.color.a = notShader.get_meta("morning").a;
		if firstCycle:
			_doDialogue("Just because you didn't do something in time doesn't mean that the world is over.", 4);
			firstCycle = false;
	label.text = str(hours) + ":";
	if minutes < 10:
		label.text += "0" + str(minutes) + ":";
	else:
		label.text += str(minutes) + ":";
	if seconds < 10:
		label.text += "0" + str(seconds);
	else:
		label.text += str(seconds);
		
	if oneShots1 and hours == 12:
		_doDialogue("A day is a very long time.");
		oneShots1 = false;


	pass # Replace with function body.



func _on_fade_timer_timeout():
	notBox.visible = false;
	pass # Replace with function body.


func _on_win_timer_timeout():
	get_tree().change_scene_to_file("res://main_menu.tscn");
	pass # Replace with function body.


func _on_audio_stream_player_finished():
	$Music.play();
	pass # Replace with function body.
