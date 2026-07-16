extends Control

var person

var universal_skills = ['oral','anal','petting']


onready var stats = $StatsPanel
#var loyalty_mode = true
#var relations_mode = true
#var loyalty_tab = 3
enum tab_nums {all, food, mastery, training, relations, kin, minor, metrics, thralls, stats}

var cur_tab
var last_tab

var foodicons = {
	meat = load("res://assets/images/gui/gui icons/icon_meat.png"),
	fish = load("res://assets/images/gui/gui icons/icon_fish.png"),
	vege = load("res://assets/images/gui/gui icons/icon_veg.png"),
	grain = load("res://assets/images/gui/gui icons/icon_grain.png"),
}

func _ready():
	update()

	globals.connecttexttooltip($personality/PersonalityTooltip, tr("INFOPERSONALITY"))
	globals.connecttexttooltip($personality/bold, tr("INFOPERSONALITYBOLD"))
	globals.connecttexttooltip($personality/shy, tr("INFOPERSONALITYSHY"))
	globals.connecttexttooltip($personality/kind, tr("INFOPERSONALITYKIND"))
	globals.connecttexttooltip($personality/serious, tr("INFOPERSONALITYSERIOUS"))

	globals.connecttexttooltip($food/fooddisliked, "[center]"+ tr("STATFOOD_HATE") + "[/center]\n"+tr("STATFOOD_HATEDESCRIPT"))
	globals.connecttexttooltip($food/foodliked,"[center]"+ tr("STATFOOD_LOVE") + "[/center]\n"+tr("STATFOOD_LOVEDESCRIPT"))

	$Button.connect('pressed', self, 'show_stats')
	


func update():
	person = input_handler.interacted_character
	#show and hide here is just to get ready, open_valid_tab() makes it all right
	$RelativesPanel.build_relatives()
	build_relations()
	stats.visible = false
	stats.make_stats(person)
	
	input_handler.ActivateTutorial("TUTORIALLIST9")
	
	if person != null:
		build_personality()
		build_food()


func build_personality():
	var limit = 100
	limit = max(limit, abs(person.get_stat('personality_bold')))
	limit = max(limit, abs(person.get_stat('personality_kind')))
	
	var tmp = Vector2(-person.get_stat('personality_kind') , -person.get_stat('personality_bold'))
	tmp /= limit
	tmp = input_handler.rect2rombus(tmp)
	tmp /= 2.0
	
	$personality/current.rect_position = Vector2($personality.rect_size.x * (0.5 + tmp.x),  $personality.rect_size.y * (0.5 + tmp.y)) - $personality/current.rect_size * 0.5
	
	$personality/PersonalityLabel.text = tr("PERSONALITYCURRENT") +"\n" + tr("PERSONALITYNAME"+person.get_stat('personality').to_upper())
	globals.connecttexttooltip($personality/PersonalityTooltip, globals.get_character_personality_tooltip(person.get_stat('personality')))
	#2add
	#$personality/desc.bbcode_text = ""


func build_food():
	$food/foodlikedicon.texture = foodicons[person.food.food_love]
	globals.connecttexttooltip($food/foodlikedicon, tr("FOODTYPE" + person.food.food_love.to_upper()))
	input_handler.ClearContainer($food/fooddislikedicons)
	for i in person.food.food_hate:
		var newicon = input_handler.DuplicateContainerTemplate($food/fooddislikedicons)
		newicon.texture = foodicons[i]
		globals.connecttexttooltip(newicon, tr("FOODTYPE" + i.to_upper()))


func build_relations():
	var text = ''
	
	var array = ResourceScripts.game_party.find_all_relationship(person.id)
	for i in array:
		var character = characters_pool.get_char_by_id(i['char'])
		#stub
		if character.get_full_name().begins_with('Child of'):
			continue
		
		text += character.get_full_name() + ": " + tr("RELATIONSHIP" + i.relationship.to_upper()) + "\n"
	$RelativesPanel/Relations.bbcode_text = text


func show_stats():
	stats.show()
