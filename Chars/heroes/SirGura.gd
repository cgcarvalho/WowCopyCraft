
class_name SirGura
extends Character

	
func _ready():
	charName = "SirGura"
	charType = Character.HeroType.HERO
	charTotalLife = 100
	charCurrentLife = 100
	
	addSkillsChar()
	start()
	

func addSkillsChar() -> void:
	var skill1 = ShadowBolt.new()
	skillList["skill_1"] = skill1
	
	var skill2 = Corruption.new()
	skillList["skill_2"] = skill2
	
	var skill3 = GreaterHeal.new()
	skillList["skill_3"] = skill3
	
