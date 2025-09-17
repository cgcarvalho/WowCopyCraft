

class_name Skill
extends Area2D

#Basic Stats
var skillName : String
var skillBaseDamage : float

var scenePath : String

var hold : bool = false
var targetPosition

func start():
	showSkill(false)

func _process(delta):
	var move_speed = 500
	if hold == true:
		$AnimatedSprite2D.play()
		global_position = global_position.move_toward(targetPosition, delta * move_speed)
		hold = !global_position.is_equal_approx(targetPosition)
	else:
		showSkill(false)
		$AnimatedSprite2D.stop()


func cast(gb):
	global_position = gb
	targetPosition = Vector2(700, 185)
	hold = true
	showSkill(true)


func showSkill(show) -> void:
	$AnimatedSprite2D.visible = show 
