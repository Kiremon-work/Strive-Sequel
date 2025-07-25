extends "res://src/scenes/ClosingPanel.gd"
#warning-ignore-all:return_value_discarded

var selectedquest

func _ready():
	$CompleteButton.connect("pressed", self, "CompleteQuest")
	$CancelButton.connect("pressed", self, "CancelQuest")
	
	$ItemSelectionPanel/CancelButton.connect("pressed",self, 'hide_item_selection')
	$ItemSelectionPanel/ConfirmButton.connect("pressed", self, "turn_in_quest_items")

func open():
	show()
	$CancelButton.visible = false
	$CompleteButton.visible = false
	$QuestDescript.clear()
	input_handler.ClearContainer($ScrollContainer/VBoxContainer)
	$rewards.hide()
	$reqs.hide()
	$Label.hide()
	$Label2.hide()
	$Time.hide()
	hide_item_selection()
	for i in ResourceScripts.game_progress.active_quests:
		make_active_quest_button(i)
	for i in ResourceScripts.game_world.areas.values():
		for guild in i.quests.factions:
			for quest in i.quests.factions[guild].values():
				if quest.state == 'taken':
					make_quest_button(quest)
		for quest in i.quests.global.values():
			if quest.state == 'taken':
				make_quest_button(quest)

func make_active_quest_button(quest):
	var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = scenedata.quests[quest.code].stages[quest.stage].name
	newbutton.connect("pressed", self, "show_quest_info", [quest])
	newbutton.set_meta("quest", quest)
	newbutton.modulate = Color(1,1,0.3)

func make_quest_button(quest):
	var newbutton = input_handler.DuplicateContainerTemplate($ScrollContainer/VBoxContainer)
	newbutton.text = quest.name
	newbutton.connect("pressed", self, "show_quest_info", [quest])
	newbutton.set_meta("quest", quest)

func show_quest_info(quest):
	$rewards.show()
	$reqs.show()
	$Label.show()
	$Label2.show()
	$Time.show()
	input_handler.ClearContainer($reqs)
	input_handler.ClearContainer($rewards)
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i.has_meta('quest'):
			i.pressed = i.get_meta('quest') == quest
	if !quest.has('stage'):
		selectedquest = quest
		for i in quest.requirements:
			var newbutton = input_handler.DuplicateContainerTemplate($reqs)
			match i.code:
				'kill_monsters':
					newbutton.texture = images.get_icon('quest_enemy')
					newbutton.get_node("amount").text = str(i.value)
					newbutton.get_node("amount").show()
					newbutton.hint_tooltip = "Defeat: " + tr(variables.enemy_types[i.type]) + " - " + str(i.curvalue) + "/" + str(i.value)
				'random_item':
					var itemtemplate = Items.itemlist[i.type]
					newbutton.texture = itemtemplate.icon
					newbutton.hint_tooltip = itemtemplate.name + ": " + str(i.value) 
					newbutton.get_node("amount").text = str(i.value)
					newbutton.get_node("amount").show()
					if itemtemplate.has('parts'):
						#newbutton.material = load("res://src/ItemShader.tres").duplicate()
						var showcase_item = globals.CreateGearItem(i.type, i.parts)
						input_handler.itemshadeimage(newbutton, showcase_item)
						globals.connectitemtooltip(newbutton, showcase_item)
						if i.has('parts'):
							newbutton.hint_tooltip += "\nPart Requirements: "
							for k in i.parts:
								newbutton.hint_tooltip += "\n"+ tr(Items.Parts[k].name)  + ": " +str(Items.materiallist[i.parts[k]].name)
				'complete_location':
					newbutton.texture = images.get_icon(i.code)
					newbutton.hint_tooltip = "Complete quest event"
					#print(i.location)
				'complete_dungeon':
					newbutton.texture = images.get_icon(i.code)
					globals.connecttexttooltip(newbutton, tr("QUESTCOMPLETEQUESTLOC2") +"[color=aqua]" + tr(ResourceScripts.game_world.areas[i.area].name) + "[/color]: [color=yellow]" + tr(i.locationname) + "[/color]")
				'random_material':
					newbutton.texture = Items.materiallist[i.type].icon
					newbutton.get_node("amount").show()
					newbutton.get_node("amount").text = str(i.value)
					globals.connectmaterialtooltip(newbutton, Items.materiallist[i.type], '\n\n[color=yellow]Required: ' + str(i.value) + "[/color]")
				'slave_delivery':
					newbutton.texture = images.get_icon('quest_slave_delivery')
					newbutton.get_node("amount").show()
					newbutton.get_node("amount").text = str(i.value)
					var tooltiptext = str(i.value) + "Slave(s) Required:\n"
					for k in i.statreqs:
						if k.code in ['is_master', 'is_free']:
							continue
						match k.code:
							'stat':
								if k.stat.ends_with('factor') && input_handler.globalsettings.factors_as_words:
									tooltiptext += statdata.statdata[k.stat].name +": "+ input_handler.operant_translation(k.operant) + " " +  ResourceScripts.descriptions.factor_descripts[int(k.value)] + " "  + "\n"
								else:
									tooltiptext += statdata.statdata[k.stat].name +": "+ input_handler.operant_translation(k.operant) + " " + str(k.value) + " "  + "\n"
							'sex':
								tooltiptext += "Sex: " + tr('SLAVESEX'+k.value.to_upper()) + "\n"
								
							'one_of_races':
								tooltiptext += "Race: " 
								for j in k.value:
									tooltiptext += tr("RACE" + j.to_upper()) + ", "
								tooltiptext = tooltiptext.substr(0, tooltiptext.length() - 2) + ".\n"
					tooltiptext += str(i.delivered_slaves) + "/" + str(i.value) + " slaves delivered."
					globals.connecttexttooltip(newbutton,tooltiptext)
		
		
		for i in quest.rewards:
			var newbutton = input_handler.DuplicateContainerTemplate($rewards)
			match i.code:
				'gear':
					var item = globals.CreateGearItem(i.item, i.itemparts)
					item.set_icon(newbutton)
					input_handler.ghost_items.append(item)
					globals.connectitemtooltip(newbutton, item)
				'gear_static':
					newbutton.texture = Items.itemlist[i.item].icon
					newbutton.get_node("amount").text = str(i.value)
					newbutton.get_node("amount").show()
					globals.connecttempitemtooltip(newbutton, Items.itemlist[i.item], 'geartemplate')
				'gold':
					var value = round(i.value + i.value * variables.master_charm_quests_gold_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
					newbutton.texture = images.get_icon('quest_gold')
					newbutton.get_node("amount").text = str(value)
					newbutton.get_node("amount").show()
					newbutton.hint_tooltip = "Gold: " + str(i.value) + " + " + str(round(i.value * variables.master_charm_quests_gold_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])) + " ("+tr("QUESTMASTERCHARMBONUS")+")"
				'reputation':
					var value = round(i.value + i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))])
					newbutton.texture = images.get_icon(i.code)
					newbutton.get_node("amount").text = str(value)
					newbutton.get_node("amount").show()
					newbutton.hint_tooltip = tr("QUESTREPUTATION") + " (" + quest.source.capitalize() + "): " + str(i.value) + " + " + str(round(i.value * variables.master_charm_quests_rep_bonus[int(ResourceScripts.game_party.get_master().get_stat('charm_factor'))]))+ " ("+tr("QUESTMASTERCHARMBONUS")+")"
				'material':
					var material = Items.materiallist[i.item]
					newbutton.texture = material.icon
					newbutton.get_node("amount").text = str(i.value)
					newbutton.get_node("amount").show()
					globals.connectmaterialtooltip(newbutton, material)
				'usable':
					var item = Items.itemlist[i.item]
					newbutton.texture = item.icon
					globals.connecttempitemtooltip(newbutton, item, 'geartemplate')
					newbutton.get_node("amount").text = str(i.value)
					newbutton.get_node("amount").show()
		$QuestDescript.bbcode_text = '[center]' + quest.name + '[/center]\n' + quest.descript
		$Time/Label.text = "Limit: " + str(quest.time_limit) + " days."
		$CancelButton.visible = true
		$CompleteButton.visible = true
	else:
		$rewards.hide()
		$reqs.hide()
		$Label.hide()
		$Label2.hide()
		$Time.hide()
		$CancelButton.visible = false
		$CompleteButton.visible = false
		var quest_stage = scenedata.quests[quest.code].stages[quest.stage]
		$QuestDescript.bbcode_text = globals.TextEncoder('[center]' + tr(quest_stage.name) + '[/center]\n' + tr(scenedata.quests[quest.code].summary) + "\n\n" + tr(quest_stage.descript))


var selectedslave

func CompleteQuest():
	var text = ''
	var check = true
	if variables.ignore_quest_requirements:
		CompleteReqs()
		return
	
	for i in selectedquest.requirements:
		if i.code == 'random_item' && i.completed == false:
			select_items_for_quest(i)
			return
		elif i.code == 'slave_delivery' && i.completed == false:
			select_character_for_quest(i)
			return
	if selectedquest.state == 'taken':
		for i in selectedquest.requirements:
			match i.code:
				'kill_monsters':
					check = i.value <= i.curvalue
				"random_material":
					check = ResourceScripts.game_res.if_has_material(i.type, 'gte', i.value)
				"random_item":
					check = i.completed
				"slave_delivery":
					check = i.delivered_slaves == i.value
				'complete_dungeon','complete_location':
					check = ResourceScripts.world_gen.get_location_from_code(i.location).completed
			if check == false:
				break
		if check == false:
			input_handler.SystemMessage(tr("REQUIREMENTSARENTMET"))
			input_handler.PlaySound("error")
			return
		else:
			CompleteReqs()

func select_character_for_quest(reqs):
	selected_req = reqs
	input_handler.ShowSlaveSelectPanel(self, 'character_selected', reqs.statreqs)

func character_selected(character):
	ResourceScripts.game_party.remove_slave(character, true)
	selected_req.completed = true
	CompleteQuest()
	input_handler.rebuild_slave_list()

func CompleteReqs():
	for i in selectedquest.requirements:
		match i.code:
			"random_material":
				ResourceScripts.game_res.update_materials(i.type, '-', i.value)
#	selectedquest.state = 'complete'
	globals.text_log_add("quests", "Quest Complete: " + selectedquest.name)
	ResourceScripts.game_world.complete_quest(selectedquest, 'complete')
	globals.Reward(selectedquest)
	open()



func CancelQuest():
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'cancel_quest_confirm', "Forfeit This Quest?"])
	#input_handler.ShowConfirmPanel(self, "cancel_quest_confirm", "Forfeit This Quest?")

func cancel_quest_confirm():
	ResourceScripts.game_world.complete_quest(selectedquest, 'failed')
	open()

var selected_items = []
var selected_req

func select_items_for_quest(quest_req):
	$ItemSelectionPanel.show()
	selected_items.clear()
	selected_req = quest_req
	$ItemSelectionPanel/ConfirmButton.disabled = true
	input_handler.ClearContainer($ItemSelectionPanel/ScrollContainer/GridContainer)
	var array = []
	for i in ResourceScripts.game_res.items.values():
		if !i.itembase == quest_req.type || i.owner != null:
			continue
		array.append(i)
	$ItemSelectionPanel/noitems.visible = array.size() == 0
	for i in array:
		var newbutton = input_handler.DuplicateContainerTemplate($ItemSelectionPanel/ScrollContainer/GridContainer)
		newbutton.connect('pressed', self, 'item_pressed', [i])
		i.set_icon(newbutton.get_node("TextureRect"))
		globals.connectitemtooltip(newbutton, i)
		if i.amount > 1:
			newbutton.get_node("Amount").text = str(i.amount)
			newbutton.get_node("Amount").show()
	item_selection_update()

func item_pressed(item):
	if selected_items.has(item):
		selected_items.erase(item)
	else:
		selected_items.append(item)
	item_selection_update()

func item_selection_update():
	var existing_items = {}
	for i in selected_items:
		input_handler.AddOrIncrementDict(existing_items, {i.itembase : i.amount})
	var amount = 0
	if existing_items.has(selected_req.type):
		amount = existing_items[selected_req.type]
	#print(existing_items, selected_items)
	var text = 'Required Items: ' + Items.itemlist[selected_req.type].name + ": " + str(amount) + "/"+ str(selected_req.value) + '.'
	$ItemSelectionPanel/RichTextLabel.bbcode_text = text
	
	
	$ItemSelectionPanel/ConfirmButton.disabled = amount < selected_req.value



func hide_item_selection():
	$ItemSelectionPanel.hide()

func turn_in_quest_items():
	var amount = selected_req.value
	for i in selected_items:
		if i.amount < amount:
			amount -= i.amount
			i.amount = 0
		else:
			i.amount -= amount
		
	selected_req.completed = true
	$ItemSelectionPanel.hide()
	CompleteQuest()
