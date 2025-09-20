

class_name Character

extends Area2D

enum HeroType {HERO, ENEMY}
@export var speed = 400 # How fast the player will move (pixels/sec).
signal targeted
var screen_size 

#region Character Properties
#HP
var charProgressBar
var charTotalLife: int
var charCurrentLife: int

#Basic Stats
var charName: String

#Target
var charCurrentTarget : Character
var charType : HeroType

#Skills
var skillList : Dictionary[String, Skill] 

#endregion

#region Start
func start():
	screen_size = get_viewport_rect().size

	registerEvents()
	startProgressBar()

func registerEvents():
	if charType == HeroType.HERO:
		for child in get_parent().get_children(false):
			child.connect("targeted", Callable(self, "on_targeted"))

func startProgressBar():
	charProgressBar = preload("res://Components/progressBar.tscn").instantiate().duplicate()
	add_child(charProgressBar)
	charProgressBar.start(charType, charCurrentLife)

#endregion

#region Events
func on_targeted(target : Character):
	if charCurrentTarget != null and charCurrentTarget != target:
		charCurrentTarget.charProgressBar.showProgressBar(false)
	charCurrentTarget = target
	
func _process(delta):
	processMoviment(delta)
	processSkills(delta)

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				charProgressBar.showProgressBar(true)
				targeted.emit(self)
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				charProgressBar.showProgressBar(false)
	
#endregion

#region Process
func processMoviment(delta):
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

func processSkills(delta):
	var loadSkill = null
	
	if charCurrentTarget != null:
		if skillList.has("skill_1") and Input.is_action_just_released("skill_1"):
			loadSkill = load(skillList["skill_1"].filePath).instantiate().duplicate()
			
		if skillList.has("skill_2") and Input.is_action_just_released("skill_2"):
			loadSkill = load(skillList["skill_2"].filePath).instantiate().duplicate()
			
		if skillList.has("skill_3") and Input.is_action_just_released("skill_3"):
			loadSkill = load(skillList["skill_3"].filePath).instantiate().duplicate()
		
		if skillList.has("skill_4") and Input.is_action_just_released("skill_4"):
			loadSkill = load(skillList["skill_4"].filePath).instantiate().duplicate()
	
		if loadSkill != null:
			loadSkill.start(self)
			add_child(loadSkill)
			loadSkill.cast(charCurrentTarget)

#endregion
