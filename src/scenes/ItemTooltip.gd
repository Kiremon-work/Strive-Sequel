extends Panel

var parentnode
var shutoff = false
var prevnode
onready var iconnode = $IconFrame/Image
onready var textnode = $RichTextLabel

var currentdata
var currenttype
var mode = 'default'

func _process(delta):
	if weakref(parentnode).get_ref() == null || weakref(parentnode) == null:
		hide()
		return
	if parentnode != null && (parentnode.is_visible_in_tree() == false || !parentnode.get_global_rect().has_point(get_global_mouse_position())):
		set_process(false)
		hide()

func _input(event):
	if event.is_pressed():
		if event.is_action("shift"):
			mode = 'advanced'
			update()
	elif event.is_action_released("shift"):
		mode = 'default'
		update()

func _init():
	set_process(false)

func update():
	showup(parentnode, currentdata, currenttype)

func showup(node, data, type): #types material materialowned gear geartemplate
	if node == null:
		return
	parentnode = node
	currentdata = data
	currenttype = type

	var screen = get_viewport().get_visible_rect()
	if shutoff == true && prevnode == parentnode:
		return

	#$Image/amount.hide()
	iconnode.material = null
	#$type.text = ''
	match type:
		'material':
			material_tooltip(data)
		'materialowned':
			var workers_data = {}
			if node.has_meta("max_workers"):
				workers_data = {
					max = node.get_meta("max_workers"),
					current = node.get_meta("current_workers"),
				}
			if node.has_meta("gather_mod"):
				workers_data = {
					gather_mod = node.get_meta("gather_mod"),
				}
			material_tooltip(data, workers_data)
		'gear':
			if mode == 'default':
				gear_tooltip(data)
			elif mode == 'advanced':
				gear_detailed_tooltip(data)
		'geartemplate':
			geartemplete_tooltip(data)
	prevnode = parentnode

	input_handler.GetTweenNode(self).stop_all()
	self.modulate.a = 1

	show()

	var pos = node.get_global_rect()
	if node.has_meta("exploration"):
		pos = Vector2(pos.end.x + 10, pos.position.y - 30)
	else:
		pos = Vector2(pos.end.x + 10, pos.position.y)
	self.set_global_position(pos)

	$RichTextLabel.rect_size.y = 125
	rect_size.y = 362

	yield(get_tree(), 'idle_frame')

	rect_size.y = max(362, $RichTextLabel.get_v_scroll().get_max() + 300)
	$RichTextLabel.rect_size.y = rect_size.y - 100
	$RichTextLabel.rect_position.y = 250


	if get_rect().end.x > screen.size.x:
		if node.has_meta("exploration") || type == "gear":
			pos = Vector2(pos.x - rect_size.x - node.rect_size.x - 10, pos.y)
			self.set_global_position(pos)
		else:
			rect_global_position.x -= screen.size.x - get_rect().end.x
	if get_rect().end.y > screen.size.y:
		rect_global_position.y -= get_rect().end.y - screen.size.y#node.get_global_rect().position.y - rect_size.y
	if data.has("type") && data.type == "tattoo":
		rect_global_position.x = 200
	if gui_controller.date_panel != null && gui_controller.date_panel.is_visible():
		rect_global_position.x = 695
	set_process(true)

func material_tooltip(data, workers_data = {}):
	var item = data.item
	var text = data.text
	if ResourceScripts.game_res.materials.has(data.item) && ResourceScripts.game_res.materials[data.item] > 0:
		text += "\n\n" + tr("CURRENTLYINPOSSESSION") + ": " + str(ResourceScripts.game_res.materials[data.item])
	if workers_data.has("max"):
		text += "\nMax Workers: " + str(workers_data.max)
		text += "\nCurrent Workers: " + str(workers_data.current)
	if workers_data.has("gather_mod"):
		text += "\nGathering Mod: " + str(workers_data.gather_mod) + "%"
	iconnode.texture = item.icon
	$Cost/Label.text = str(item.price)
	$Cost.visible = int(item.price) != 0
	textnode.bbcode_text = globals.TextEncoder(text)
#	$type.text = tr('MATERIALCATEGORY' + item.type.to_upper())

func materialowned_tooltip(data):
	material_tooltip(data)
	#$Image/amount.show()
	#$Image/amount.text = str(state.materials[data.item.code])


func gear_tooltip(data, item = null):
	if item == null:
		item = data.item
	var text = item.tooltiptext()
	$Cost/Label.text = str(data.price)
	$Cost.visible = item.price != 0

	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)
		text += "\n\n{color=yellow|" + tr("INFOHOLDSHIFT") + "[/color]"
	else:
		iconnode.texture = input_handler.loadimage(item.icon, 'icons')

	textnode.bbcode_text = text

func gear_detailed_tooltip(data, item = null):
	gear_tooltip(data, item)
	item = data.item
	if item.parts.size() == 0:
		return
	var text = '[center]{color=k_yellow|' + data.item.name +'}[/center]'
	for i in item.parts:
		var material = Items.materiallist[item.parts[i]]
		# text += '\n' + tr(Items.Parts[i].name) + ": {color=yellow|" + material.name +"}"
		for k in material.parts[i]:
			if material.parts[i][k] != 0:
				var value = material.parts[i][k]
				var change = ''
				if k in ['hpmod', 'manamod','task_energy_tool', 'task_efficiency_tool']:
					value = value*100
				text += '\n' + statdata.statdata[k].name + ': {color='
				if value > 0:
					change = '+'
					text += 'green|' + change
				else:
					text += 'red|'
				value = str(value)
				if k in ['hpmod', 'manamod','task_energy_tool', 'task_efficiency_tool']:
					value = value + '%'
				text += value + '}'
#		for k in material.parts[i]:
#			text += "\n" + Items.stats[k] + " " + str(material.parts[i][k])
	textnode.bbcode_text = globals.TextEncoder(text)

func geartemplete_tooltip(data):
	var item = data.item
	var text = '[center]' + item.name + '[/center]\n'
	
	if item.has('geartype'):
		text += tr('TYPE_LABEL') + ': ' + item.geartype + "\n"
		if item.slots.size() > 0:
			text += tr("SLOTS_LABEL") + ": "
			for i in item.slots:
				text += tr("ITEMSLOT"+i.to_upper()) + ", "
			text = text.substr(0, text.length() -2) + ". \n"
	else:
		text += tr("TYPE_USABLE_LABEL") + "\n"
	
	text += item.descript
	
	if item.itemtype in ['armor','weapon','tool']:
		text += "\n\n" + globals.build_desc_for_bonusstats(item.basestats)
	
	for i in item.effects:
		text += tr(Effectdata.effect_table[i].descript) + "\n"
	
	iconnode.texture = item.icon
	$Cost/Label.text = str(data.price)



#	if data.item.slots.size() == 1:
#		$type.text += tr("ITEMSLOT" + data.item.slots[0].to_upper())
#	elif data.item.slots.size() > 1:
#		$type.text += 'Multislot'
#	else:
#		$type.text = tr("USABLE")
	if item.get('partcolororder') != null:
		input_handler.itemshadeimage(iconnode, item)

		text += "\n\n{color=yellow|" + tr("INFOHOLDSHIFT") + "}"
	textnode.bbcode_text = globals.TextEncoder(text)


func cooldown():
	shutoff = true
	yield(get_tree().create_timer(0.2), 'timeout')
	shutoff = false

func hide():
	parentnode = null
	set_process(false)
	ResourceScripts.core_animations.FadeAnimation(self, 0.2)
