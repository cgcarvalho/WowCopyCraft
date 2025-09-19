

class_name Skill
extends Area2D

enum SkillType {DIRECT, DOT, HEAL, HOT}
var timer = 0.0
var skillTimer = 0.0

#region Skill Properties
#Basic Stats
var skillName : String
var skillBaseDamage : float
var skillDotSeconds : int
var skillType : SkillType

var scenePath : String

var hold : bool = false
var skillCaster : Character
var skillTarget : Character

#endregion

#region Start
func start(caster : Character):
	skillCaster = caster
#endregion

#region Events

func _process(delta):
	if skillType == SkillType.DIRECT:
		processDirectDamage(delta)
	if skillType == SkillType.DOT:
		processDamageOverTime(delta)
#endregion

#region Process
func processDirectDamage(delta) -> void:
	if hold == true:
		var move_speed = 500
		$AnimatedSprite2D.play()
		global_position = global_position.move_toward(skillTarget.global_position, delta * move_speed)
		hold = !global_position.is_equal_approx(skillTarget.global_position)
	else:
		$AnimatedSprite2D.stop()
		get_parent().remove_child(self)
		skillTarget.charCurrentLife += -skillBaseDamage
		skillTarget.charProgressBar.updateValue(skillTarget.charCurrentLife)

func processDamageOverTime(delta) -> void:
	if hold == true:
		timer += delta
		skillTimer += delta
		
		if timer >= 1.0 and skillTimer <= skillDotSeconds:
			$AnimatedSprite2D.play()
			
			skillTarget.charCurrentLife += -skillBaseDamage
			skillTarget.charProgressBar.updateValue(skillTarget.charCurrentLife)
			timer = 0.0 # Reset the timer
		elif skillTimer >= skillDotSeconds:
			$AnimatedSprite2D.stop()
			hold = false
			get_parent().remove_child(self)
		
#endregion

func cast(target : Character):
	if target != null:
		skillTarget = target
		setSkillInicialPosition()
		hold = true
		
func setSkillInicialPosition() -> void:
	if skillType == SkillType.DIRECT:
		global_position = skillCaster.global_position
	elif skillType == SkillType.DOT:
		global_position = skillTarget.global_position
		global_position.y = skillTarget.global_position.y - 170
