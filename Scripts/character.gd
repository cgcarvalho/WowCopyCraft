

class_name Character

extends Area2D
signal hit

enum HeroType {HERO, ENEMY}
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size 

#HP
var charProgressBar
var charTotalLife: int
var charCurrentLife: int

#Basic Stats
var charName: String
var charmovement: int

#Target
var charCurrentTarget : Character
var charType : HeroType

#Skills
var skillList : Dictionary[String, Skill] 


func start(ht : HeroType, cl : int, nm : String):
	screen_size = get_viewport_rect().size
	
	charName = nm
	charCurrentLife = cl
	charType = ht
	
	addSkills()
	startProgressBar()

func _process(delta):
	processoMoviment(delta)
	processSkills(delta)

func processoMoviment(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if charType == HeroType.HERO:
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
func startProgressBar():
	charProgressBar = preload("res://Components/progressBar.tscn").instantiate().duplicate()
	add_child(charProgressBar)
	charProgressBar.start(charType, charCurrentLife)
	
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				charProgressBar.showProgressBar(true)
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				charProgressBar.showProgressBar(false)
	

func addSkills() -> void:
	if "skill_1" in skillList:
		var loadSkill = load(skillList["skill_1"].filePath).instantiate().duplicate()
		add_child(loadSkill)
		skillList["skill_1"] = loadSkill
		skillList["skill_1"].start()

	
func processSkills(delta):
	if skillList.has("skill_1") and Input.is_action_pressed("skill_1"):
		skillList["skill_1"].cast(global_position)
		
	if Input.is_action_pressed("skill_2"):
		pass
	if Input.is_action_pressed("skill_3"):
		pass
	if Input.is_action_pressed("skill_4"):
		pass


func _on_area_entered(area: Area2D) -> void:
	print("oiii")
	pass # Replace with function body.
