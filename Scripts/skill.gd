

class_name Skill
extends Area2D

#Basic Stats
var skillName : String

var skillBaseDamage : float

var scenePath : String

var skillSprite : AnimatedSprite2D

var hold : bool = false
var casterPosition
var targetPosition

func start():
	skillSprite = $AnimatedSprite2D
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
	$AnimatedSprite2D.stop()
	global_position = gb
	targetPosition = Vector2(700, 185)
	hold = true
	showSkill(true)


func showSkill(show) -> void:
	skillSprite.visible = show 



func _on_area_entered(area: Area2D) -> void:
	print("shadow bolt" + " " + area.to_string())
