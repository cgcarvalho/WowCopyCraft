

class_name Skill
extends Area2D

enum SkillType {DIRECT, DOT, HEAL, HOT}
var timer = 0.0
var skillTimer = 0.0
var projectileSpeed = 500

#region Skill Properties
#Basic Stats
var skillName : String
var skillBaseDamage : float
var skillBaseHeal : float
var skillDotSeconds : int
var skillType : SkillType

var scenePath : String

var hold : bool = true
var skillCaster : Character
var skillTarget : Character

#endregion

#region Start
func start(caster : Character):
	skillCaster = caster
	$AnimatedSprite2D.z_index = 1

#endregion

#region Events

func _process(delta):
	match skillType:
		SkillType.DIRECT:
			processDirectDamage(delta)
		SkillType.DOT:
			processDamageOverTime(delta)
		SkillType.HEAL:
			processHeal(delta)
#endregion

#region Process
func processDirectDamage(delta) -> void:
	if hold == true:
		global_position = global_position.move_toward(skillTarget.global_position, delta * projectileSpeed)
		hold = !global_position.is_equal_approx(skillTarget.global_position)
	else:
		get_parent().remove_child(self)
		skillTarget.charCurrentLife += -skillBaseDamage
		skillTarget.charProgressBar.updateValue(skillTarget.charCurrentLife)

func processDamageOverTime(delta) -> void:
	timer += delta
	skillTimer += delta
	
	if timer >= 1.0 and skillTimer <= skillDotSeconds:
		skillTarget.charCurrentLife += -skillBaseDamage
		skillTarget.charProgressBar.updateValue(skillTarget.charCurrentLife)
		timer = 0.0 
	elif skillTimer >= skillDotSeconds:
		get_parent().remove_child(self)

func processHeal(delta) -> void:
	if hold == true:
		hold = $AnimatedSprite2D.is_playing()
	else:
		get_parent().remove_child(self)
		skillTarget.charCurrentLife += skillBaseHeal
		
		if skillTarget.charCurrentLife > skillTarget.charTotalLife:
			skillTarget.charCurrentLife = skillTarget.charTotalLife
		
		skillTarget.charProgressBar.updateValue(skillTarget.charCurrentLife)
#endregion

func cast(target : Character):
	if target != null:
		skillTarget = target
		$AnimatedSprite2D.play()
		setSkillInicialPosition()
		
func setSkillInicialPosition() -> void:
	
	match skillType:
		SkillType.DIRECT:
			global_position = skillCaster.global_position
		SkillType.DOT:
			global_position = skillTarget.global_position
			global_position.y = skillTarget.global_position.y - 170
		SkillType.HEAL:
			global_position = skillTarget.global_position
			global_position.y = skillTarget.global_position.y + 50 
