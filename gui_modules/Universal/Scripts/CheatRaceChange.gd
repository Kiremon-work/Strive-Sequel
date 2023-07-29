extends Panel

var selected_race = ""
var selected_person



func _ready():
	$ConfirmButton.connect("pressed", self, "select_character_race")
	$CancelButton.connect("pressed", self, "cancel_race_selection")



func select_race(person):
	show()
	selected_person = person
	selected_race = person.get_stat("race")
	input_handler.ClearContainer($RaceSelection/ScrollContainer/VBoxContainer)
	for i in races.racelist.values():
		var newbutton = input_handler.DuplicateContainerTemplate($RaceSelection/ScrollContainer/VBoxContainer)
		if person.get_stat('race') == i.code: newbutton.pressed = true
		newbutton.text = i.name
		newbutton.connect("pressed", self, "show_race_info", [i.code])
	show_race_info(person.get_stat('race'))


func show_race_info(temprace):
	selected_race = temprace
	var race = races.racelist[temprace]
	var image
	var text = race.descript

	text += tr("\n\n{color=yellow|" + "RACE_BONUSES" + ": ")
	for i in race.race_bonus:
		if (i as String).begins_with('resist'):
			text += i.replace("resist_","").capitalize() + " Resist: " + str(race.race_bonus[i]) + "%, "
			continue
		if statdata.statdata[i].percent == true:
			text += statdata.statdata[i].name + ": " + str(race.race_bonus[i]*100) + '%, '
		else:
			text += statdata.statdata[i].name + ": " + str(race.race_bonus[i]) + ', '
	text = text.substr(0, text.length() - 2) + ".}"

	$RaceSelection/RichTextLabel.bbcode_text = globals.TextEncoder(text)
	text = race.code.to_lower().replace('halfkin','beastkin')
	var tmp = selected_person.get_stat('sex')
	if tmp != null:
		if tmp == 'male':
			text += "_m"
		else:
			text += "_f"

		if images.shades.has(text):
			image = images.shades[text]

	$RaceSelection/TextureRect.texture = image
	update_buttons()

func update_buttons():
	for button in $RaceSelection/ScrollContainer/VBoxContainer.get_children():
		if button.name == "Button":
			continue
		button.pressed = selected_race == button.text


func select_character_race():
	hide()
	selected_person.set_stat('race', selected_race)



func cancel_race_selection():
	hide()
