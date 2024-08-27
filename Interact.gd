extends Sprite2D



signal touch;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_physics_body_entered(body):
	if body.startSpeed:
		Global.win = true;
		touch.emit();
		get_node("winTimer").start(3);
		pass
	pass # Replace with function body.
