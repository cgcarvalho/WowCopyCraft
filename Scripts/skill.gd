

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
	var move_speed = 10
	if hold == true:
		$AnimatedSprite2D.play()
		skillSprite.position = skillSprite.position.lerp(targetPosition, delta * move_speed)
		hold = !skillSprite.position.is_equal_approx(targetPosition)
	else:
		showSkill(false)
		$AnimatedSprite2D.stop()


func cast(gb):
	$AnimatedSprite2D.stop()
	
	skillSprite.position = gb
	targetPosition = Vector2(1550, 185)
	hold = true
	showSkill(true)


func showSkill(show) -> void:
	skillSprite.visible = show 



func _on_area_entered(area: Area2D) -> void:
	print("shadow bolt" + " " + area.to_string())
	pass # Replace with function body.
