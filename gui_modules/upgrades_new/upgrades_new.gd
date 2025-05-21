extends "res://src/scenes/ClosingPanel.gd"

onready var upgrades = $ScrollContainer
onready var upgradeslist = $ScrollContainer/UpgradesList
onready var queue = $QueueList
onready var queuelist = $QueueList/ScrollContainer/VBoxContainer
onready var chars = $CharList
onready var charlist = $CharList/ScrollContainer/VBoxContainer
onready var modes = $Modes
onready var desc_panel = $description
onready var res_list = $description/VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer
onready var work_cost = $description/workunits/Label
onready var upgrade_tabs = $Modes2

var upgrades_order = []
var selected_upgrade = null
var tree_tab = 1

func _ready():
	add_to_group("pauseprocess")
	gui_controller.upgrades = self
	$Modes/Mode1.connect("pressed", self, "open_tree", [tree_tab])
	$Modes/Mode2.connect("pressed", self, "open_queue", [])
	$Modes/Mode3.connect("pressed", self, "open_chars", [])
	for t in range(1, upgrade_tabs.get_child_count() + 1):
		var temp = upgrade_tabs.get_child(t - 1)
		temp.set_meta('tab', t)
		temp.connect('pressed', self, 'select_tab', [t])
	$CancelButton.connect("pressed", self, "hide", [])
	$description/Confirm.connect("pressed", self, "add_upgrade_to_queue", [])
	globals.connecttexttooltip($description/workunits, tr("TOOLTIPPROGRESSREQUIRED"))
	globals.connecttexttooltip($TaxLabel, tr("TOOLTIPTAX"))


func show():
	gui_controller.clock.visible = false
	gui_controller.current_screen = self
	if !gui_controller.windows_opened.has(self):
		gui_controller.windows_opened.append(self)
	.show()
	open_tree(tree_tab)
	desc_panel.visible = false


func hide():
	if !visible: return
	gui_controller.current_screen = gui_controller.mansion
	if gui_controller.clock != null:
		gui_controller.clock.visible = true
#		gui_controller.clock.restoreoldspeed()
	if get_parent().mansion_state == 'upgrades':
		get_parent().mansion_state = 'default'
	else:
		.hide()






func select_upgrade(code):
	if selected_upgrade != code:
		selected_upgrade = code
	for panel in upgradeslist.get_children():
		panel.match_selected(code)
	build_description(code)


func build_description(upgrade_id):
	if upgrade_id == null: 
		desc_panel.visible = false
		return
	var upgrade_data = upgradedata.upgradelist[upgrade_id]
	var upgrade_lv = ResourceScripts.game_res.findupgradelevel(upgrade_id)
	var upgrade_state = null
	if upgrade_lv > 0:
		upgrade_state = upgrade_data.levels[upgrade_lv]
	var upgrade_next_state = null
	if upgrade_data.levels.has(upgrade_lv + 1):
		upgrade_next_state = upgrade_data.levels[upgrade_lv + 1]

	desc_panel.visible = true

	var text = tr(upgrade_data.name) + " Level "
	if upgrade_next_state == null:
		text +=  str(upgrade_lv)
	else:
		text += str(upgrade_lv + 1)
	desc_panel.get_node("VBoxContainer/desc_header").text = text #+ " description"
	text = tr(upgrade_data.descript) + "\n"
	if upgrade_next_state != null:
		text += tr(upgrade_next_state.bonusdescript)
	else:
		text += tr(upgrade_state.bonusdescript)

	var can_upgrade = true
	desc_panel.get_node("VBoxContainer/MarginContainer/ScrollContainer").visible = true
	desc_panel.get_node("VBoxContainer/resources").visible = true
	work_cost.get_parent().visible = true

	if ResourceScripts.game_res.upgrades_queue.has(upgrade_id):
		desc_panel.get_node("VBoxContainer/MarginContainer/ScrollContainer").visible = false
		desc_panel.get_node("VBoxContainer/resources").visible = false
		work_cost.get_parent().visible = false
		can_upgrade = false
		text += "\nUpgrade purchased. Set characters to Upgrading to start working on it.\nCurrent Progress: %d/%d" % [ResourceScripts.game_res.upgrade_progresses[upgrade_id].progress, upgrade_next_state.taskprogress]
	elif ResourceScripts.game_res.upgrade_progresses.has(upgrade_id):
		desc_panel.get_node("VBoxContainer/MarginContainer/ScrollContainer").visible = false
		desc_panel.get_node("VBoxContainer/resources").visible = false
		work_cost.get_parent().visible = false
		text += "\nUpgrade purchased but not queued. \nCurrent Progress: %d/%d" % [ResourceScripts.game_res.upgrade_progresses[upgrade_id].progress, upgrade_next_state.taskprogress]
	elif upgrade_next_state == null:
		desc_panel.get_node("VBoxContainer/MarginContainer/ScrollContainer").visible = false
		desc_panel.get_node("VBoxContainer/resources").visible = false
		work_cost.get_parent().visible = false
		can_upgrade = false
	elif !globals.checkreqs(upgrade_next_state.unlockreqs):
		desc_panel.get_node("VBoxContainer/MarginContainer/ScrollContainer").visible = false
		desc_panel.get_node("VBoxContainer/resources").visible = false
		work_cost.get_parent().visible = false
		can_upgrade = false
	else:
		if upgrade_next_state.has('tax'):
			text += "\n\n{color=yellow|This upgrade will increase Weekly Tax by %d}" % upgrade_next_state.tax 
		input_handler.ClearContainer(desc_panel.get_node("VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer"))
		for res in upgrade_next_state.cost:
			var panel = input_handler.DuplicateContainerTemplate(desc_panel.get_node("VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer"))
			panel.set_meta("exploration", true)
			if res != 'gold':
				var resdata = Items.materiallist[res]
				globals.connectmaterialtooltip(panel, resdata)
				panel.get_node("Icon").texture = resdata.icon
				panel.get_node("name").text = resdata.name
				panel.get_node("count").text = "%d / %d" % [ResourceScripts.game_res.materials[res], upgrade_next_state.cost[res]]
				if ResourceScripts.game_res.materials[res] < upgrade_next_state.cost[res]:
					panel.get_node("count").set("custom_colors/font_color", variables.hexcolordict.red)
					panel.disabled = true
					can_upgrade = false
				else:
					panel.get_node("count").set("custom_colors/font_color", variables.hexcolordict.green)
			else:
				panel.get_node("Icon").texture = load("res://assets/images/iconsitems/gold.png")
				panel.get_node("name").text = tr('GOLD')
				panel.get_node("count").text = "%d / %d" % [ResourceScripts.game_res.money, upgrade_next_state.cost[res]]
				if ResourceScripts.game_res.money < upgrade_next_state.cost[res]:
					panel.get_node("count").set("custom_colors/font_color", variables.hexcolordict.red)
					panel.disabled = true
					can_upgrade = false
				else:
					panel.get_node("count").set("custom_colors/font_color", variables.hexcolordict.green)
		#add working res
		work_cost.text = "%d" % [upgrade_next_state.taskprogress]
#		var panel = input_handler.DuplicateContainerTemplate(desc_panel.get_node("VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer"))
#		panel.get_node("Icon").texture = load("res://assets/Textures_v2/MANSION/icon_upgrade_64.png")
#		panel.get_node("name").text = tr("TASKBUILDING")
#		panel.get_node("count").text = "%d" % [upgrade_next_state.taskprogress]

	desc_panel.get_node("Confirm").disabled = !can_upgrade
	desc_panel.get_node("VBoxContainer/description").bbcode_text = globals.TextEncoder(text)
	$TaxLabel.text = tr("MONEYTOOLTIP2") + ": %d" % ResourceScripts.game_res.tax
	#2add here building bonuses list not existing for now


func build_queue_list():
	var upgrades = ResourceScripts.game_res.upgrades_queue
	input_handler.ClearContainer(queuelist)
	var remains = 0
	var output = ResourceScripts.game_party.get_output_for_task("building", ResourceScripts.game_world.mansion_location, true)

	for upgrade in upgrades:
		var upgrade_data = upgradedata.upgradelist[upgrade]
		var text = upgrade_data.name
		var newbutton = input_handler.DuplicateContainerTemplate(queuelist)
		newbutton.set_meta('upgrade', upgradedata.upgradelist[upgrade])
		newbutton.target_node = self
		newbutton.target_function = 'build_queue_list'
		newbutton.arraydata = upgrade
		newbutton.parentnodearray = ResourceScripts.game_res.upgrades_queue
		newbutton.get_node("name").text = text
		if upgrade_data.has('icon'):
			newbutton.get_node("Icon").texture = images.upgrade_icons[upgrade_data.icon]
		else:
			newbutton.get_node("Icon").texture = null
#		if upgrade_next_state != null:
#			if upgrade_next_state.has('icon'):
#				newbutton.get_node("Icon2").texture = images.icons[upgrade_next_state.icon]
#			else:
#				newbutton.get_node("Icon2").texture = null
#		else:
#			if upgrade_state.has('icon'):
#				newbutton.get_node("Icon2").texture = images.icons[upgrade_state.icon]
#			else:
#				newbutton.get_node("Icon2").texture = null
#		newbutton.get_node("Icon").texture =
		var currentupgradelevel = ResourceScripts.game_res.findupgradelevel(upgrade)

		remains += update_progresses(upgradedata.upgradelist[upgrade], newbutton, currentupgradelevel)

		globals.connecttexttooltip(newbutton, "Drag and drop to change order. Click to remove from queue.")
		newbutton.connect("pressed", self, "remove_from_upgrades_queue", [upgrade])
		if output > 0:
			newbutton.get_node("time").text = "%d t" % int(ceil(remains / (1.0 * output)))
		else:
			newbutton.get_node("time").visible = false


func update_progresses(upgrade, newbutton, currentupgradelevel):
	var level = int(currentupgradelevel)
	if ResourceScripts.game_res.upgrade_progresses.has(upgrade.code):
		newbutton.get_node("progress").visible = true
		newbutton.get_node("progress").value = ResourceScripts.game_res.upgrade_progresses[upgrade.code].progress
		newbutton.get_node("progress").max_value = upgrade.levels[level + 1].taskprogress
		newbutton.get_node("progress/Label").text = "%d/%d" % [ResourceScripts.game_res.upgrade_progresses[upgrade.code].progress, upgrade.levels[level + 1].taskprogress]
		return upgrade.levels[level + 1].taskprogress - ResourceScripts.game_res.upgrade_progresses[upgrade.code].progress
	else:
		newbutton.get_node("progress").visible = false
		return 0


var removing_upgrade

func remove_upgrade_confirm():
	ResourceScripts.game_res.upgrades_queue.erase(removing_upgrade)
	build_queue_list()
	build_description(selected_upgrade)


func remove_from_upgrades_queue(upgrade):
	removing_upgrade = upgrade
	input_handler.get_spec_node(input_handler.NODE_YESNOPANEL, [self, 'remove_upgrade_confirm', tr('REMOVEUPGRADEFROMQUEUEQUESTION')])


func build_characters():
	input_handler.ClearContainer(charlist)
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if !person.check_location(ResourceScripts.game_world.mansion_location, true): continue
		var newbutton = input_handler.DuplicateContainerTemplate(charlist)
		newbutton.disabled = person.is_on_quest()
		newbutton.set_meta('slave', person)

		# globals.connectslavetooltip(newbutton, person)
		update_button(newbutton, person)
		newbutton.pressed = (person.get_work() == "building")
		newbutton.connect('toggled', self, 'set_to_upgrading', [person])


func update_button(newbutton, person):
	newbutton.get_node("Icon").texture = person.get_icon_small()
	newbutton.get_node("name").text = person.get_short_name()
	var gatherable = Items.materiallist.has(person.get_work())
	if person.get_work() == '' or !person.is_avaliable():
		if person.is_on_quest():
			var time_left = int(person.get_quest_time_remains())
			if time_left > 0:
				var time_left_string = ''
				if time_left == 1:
					time_left = 4 - ResourceScripts.game_globals.hour
					time_left_string = str(time_left) + " turns" 
				else:
					time_left_string = str(time_left) + " d."
				newbutton.get_node("job/Label").text = "On Quest: " + time_left_string
			else:
				newbutton.get_node("job/Label").text = person.get_unaval_string()
		else:
			newbutton.get_node("job/Label").text = tr("TASKREST")
	else:
		if !gatherable:
			newbutton.get_node("job/Label").text = tasks.tasklist[person.get_work()].name
		else:
			newbutton.get_node("job/Label").text = "Gathering " + Items.materiallist[person.get_work()].name


func can_add_worker():
	var count = 0
	var max_count
	var task = tasks.tasklist.building
	max_count = task.base_workers + task.workers_per_upgrade * ResourceScripts.game_res.findupgradelevel(task.upgrade_code)
	for i in ResourceScripts.game_party.character_order:
		var person = ResourceScripts.game_party.characters[i]
		if !person.check_location(ResourceScripts.game_world.mansion_location, true): continue
		if person.get_work() == "building":
			count += 1
	return count < max_count

func set_to_upgrading(pressed, person):
	if pressed:
		if can_add_worker():
			person.assign_to_task("building", "building")
		else:
			input_handler.SystemMessage(tr("NO_FREE_SLOTS"))
	else:
		person.remove_from_task()
	build_characters()


func open_tree(tab_n):
	upgrades.visible = true
	upgrade_tabs.visible = true
	modes.get_node("Mode1").pressed = true
	queue.visible = false
	modes.get_node("Mode2").pressed = false
	chars.visible = false
	modes.get_node("Mode3").pressed = false

#	upgradeslist.update_upgrades_tree(tab_n)
	select_tab(tab_n)


func select_tab(tab_n):
	for node in upgrade_tabs.get_children():
		node.pressed = (node.get_meta('tab') == tab_n)
	
	if tab_n != tree_tab:
		select_upgrade(null)
		tree_tab = tab_n
	upgradeslist.update_upgrades_tree(tab_n)


func open_queue():
	upgrades.visible = false
	upgrade_tabs.visible = false
	modes.get_node("Mode1").pressed = false
	queue.visible = true
	modes.get_node("Mode2").pressed = true
	chars.visible = false
	modes.get_node("Mode3").pressed = false

	build_queue_list()


func open_chars():
	upgrades.visible = false
	upgrade_tabs.visible = false
	modes.get_node("Mode1").pressed = false
	queue.visible = false
	modes.get_node("Mode2").pressed = false
	chars.visible = true
	modes.get_node("Mode3").pressed = true

	build_characters()


func add_upgrade_to_queue():
	ResourceScripts.game_res.add_upgrade_to_queue(selected_upgrade)
	build_description(selected_upgrade)
	upgradeslist.update_upgrades_tree(tree_tab)
	build_queue_list()
	input_handler.SystemMessage("New upgrade added to queue: " + upgradedata.upgradelist[selected_upgrade].name)
