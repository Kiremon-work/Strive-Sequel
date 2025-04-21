extends Panel


var stat_index = 0
var stats = ["base_stats", "resists"]


func _ready():
	$StatsButton.connect("pressed", self, "open_base_stats")
	$ResistsButton.connect("pressed", self, "open_resists")
	for i in variables.resists_list:
		if i == 'all': continue
		var newlabel = $resists/Label.duplicate()
		var newvalue = $resists/Value.duplicate()
		$resists.add_child(newlabel)
		$resists.add_child(newvalue)
		newlabel.text = tr(i.to_upper() + "RESIST") + ":"
		newvalue.name = i
		newlabel.show()
		newvalue.show()
	for i in $base_stats.get_children():
		if statdata.statdata.has(i.name.replace("label_","")):
			globals.connecttexttooltip(i, statdata.statdata[i.name.replace("label_", "")].descript)

			
func open_base_stats():
	$resists.hide()
	$base_stats.show()
	$StatsButton.pressed = true
	$ResistsButton.pressed = false
	var character = input_handler.interacted_character
	
	for i in variables.fighter_stats_list:
		if !i in ['hpmax', 'mpmax','critmod']:
			$base_stats.get_node(i).text = str(floor(character.get_stat(i)))
		elif i == 'critmod':
			$base_stats.get_node(i).text = str(floor(character.get_stat(i)*100))
	


func open_resists():
	$resists.show()
	$base_stats.hide()
	$StatsButton.pressed = false
	$ResistsButton.pressed = true
	var character = input_handler.interacted_character
	for i in $resists.get_children():
		if !statdata.statdata.has('resist_' + i.name):
			continue
		var tmp = character.get_stat('resist_' + i.name)
		i.text = str(tmp[i.name])
		if tmp[i.name] > 0:
			i.set("custom_colors/font_color", variables.hexcolordict.yellow)
		elif tmp[i.name] < 0:
			i.set("custom_colors/font_color", variables.hexcolordict.green)
		else:
			i.set("custom_colors/font_color", variables.hexcolordict.white)


func switch_stats():
	if stat_index == stats.size() - 1:
		stat_index = 0
	else:
		stat_index += 1
	match stats[stat_index]:
		"base_stats":
			open_base_stats()
		"resists":
			open_resists()

