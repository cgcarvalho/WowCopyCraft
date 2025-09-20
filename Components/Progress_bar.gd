extends Node


var progressBar : ProgressBar
var heroType : Character.HeroType


func start(type : Character.HeroType, totalLife : int) -> void:
	heroType = type
	progressBar.max_value = totalLife
	progressBar.value = totalLife

func _ready() -> void:
	progressBar = $CanvasLayer.get_node("ProgressBar")
	showProgressBar(false)
	
func showProgressBar(show) -> void:
	progressBar.visible = show 
	if heroType == Character.HeroType.HERO:
		progressBar.position.x = 55
		progressBar.position.y = 38
	if heroType == Character.HeroType.ENEMY:
		progressBar.position.x = 811
		progressBar.position.y = 38
	

func updateValue(value) -> void:
	progressBar.value = value
