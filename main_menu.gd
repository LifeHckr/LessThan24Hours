extends Node2D
@onready var hardmode =  get_node("Button2");
@onready var text2 =  get_node("RichTextLabel2");

# Called when the node enters the scene tree for the first time.
func _ready():
	if !Global.win:
		hardmode.visible = false;
		text2.visible = false;

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Global.mode = "normal";
	get_tree().change_scene_to_file("res://main.tscn");
	pass # Replace with function body.


func _on_button_2_pressed():
	Global.mode = "fast";
	get_tree().change_scene_to_file("res://main.tscn");
	pass # Replace with function body.
