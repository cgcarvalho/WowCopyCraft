
class_name SirGura
extends Character

	
func _ready():
	charName = "SirGura"
	charType = Character.HeroType.HERO
	charTotalLife = 100
	charCurrentLife = charTotalLife
	
	addSkillsChar()
	start()
	

func addSkillsChar() -> void:
	var skill1 = ShadowBolt.new()
	skillList["skill_1"] = skill1
	
