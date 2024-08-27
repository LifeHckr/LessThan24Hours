extends CharacterBody2D

var startSpeed = 300.0;
var drag = 1500;
var runThreshold = 500;
var runMulti = 3;
var acceleration = 80;	
var maxVelocity = 1000;
var gravity = 1900;
var jumpSpeed = -205;
var jumpAccel = -1975;
var facing = 1;
var state = "walk";
var lastX = 0;
var onWall = true;

@onready var sprite = self.get_node("sprite");
@onready var anims = sprite.get_node("anims");
@onready var camera = self.get_node("camera");
@onready var body = self.get_node("body");


func _physics_process(delta):

	# Up down movement
	var uppies = Input.get_axis("up", "down")
	if uppies:
		velocity.y = uppies * 200 + 50;
		state = "fly";
	elif not uppies && state == "fly":
		velocity.y = move_toward(velocity.y, 0, startSpeed);
		if Input.is_action_just_pressed("slow"):
			state = "walk";
		
	#Add the gravity.
	if not is_on_floor() and state != "fly":
		velocity.y += gravity * delta
	else:
		velocity.y += gravity/10 * delta
	if is_on_floor():
		sprite.play("walk");
		state = "walk";

	#left right moving
	var direction = Input.get_axis("left", "right")
	if facing != direction and direction != 0:
		self.scale.x *= -1;
		facing *= -1;
	if !direction or is_on_wall():
		if state == "walk":
			velocity.x = move_toward(velocity.x, 0, startSpeed);
			sprite.pause();
		elif state == "fly":
			velocity.x = move_toward(velocity.x, 0, 8);
	else:
		if state == "walk":
			sprite.play("walk");
			velocity.x = move_toward(velocity.x, direction * startSpeed * .75, 20);
		elif state == "fly":
			velocity.x = move_toward(velocity.x, direction * (startSpeed + 400), 10);
			

	
	move_and_slide()
	
	onWall = is_on_wall();
	
	if !direction or (((abs(lastX - position.x) < 1)) and onWall):
		if state == "walk":
			sprite.pause();
		elif state == "fly":
			sprite.play("fly");
	else:
		if state == "walk":
			sprite.play("walk");
		elif state == "fly":
			sprite.play("fast");
	
	lastX = position.x;
			
func changeAnim(change):
	print_debug(sprite.animation);
	if sprite.animation != change:
		sprite.play(change);
	pass
