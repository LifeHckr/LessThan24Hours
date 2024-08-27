extends Node2D



signal touch;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_physics_body_entered(body):
	if body.get("startSpeed"):
		touch.emit();
	if get_meta("oneShot"):
		self.queue_free();
	pass # Replace with function body.
