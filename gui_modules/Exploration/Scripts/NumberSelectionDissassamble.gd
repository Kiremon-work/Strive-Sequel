extends Panel

var showntext
var target_function
var target_node
var require_gold
var cost
var icon

func _ready():
	$Button.connect('pressed', self, "confirm_number_selection")
	$HSlider.connect("value_changed", self, "change_number_selection")

func open(targetnode = null, targetfunction = null, text = '', itemcost = 0, minvalue = 1, maxvalue = 100, requiregold = false, item_icon = null):
	show()
	showntext = text
	icon = item_icon
	target_function = targetfunction
	target_node = targetnode
	cost = itemcost
	# if minvalue > 0:
	# 	$HSlider.step = minvalue
	# else:
	# 	$HSlider.step = 1
	$HSlider.value = minvalue
	$HSlider.min_value = minvalue
	$HSlider.max_value = maxvalue
	require_gold = requiregold
	update()

func update():
	# if get_parent().name == "AreaShop":
	# 	if require_gold == false:
	# 		$Button.disabled = $HSlider.value == 0
	# 	else:
	# 		$Button.disabled = $HSlider.value == 0 || ResourceScripts.game_res.money < $HSlider.value * cost
	# 	if typeof(icon) == TYPE_STRING:
	# 		$ItemIcon.texture = load(icon)
	# 	else:
	# 		$ItemIcon.texture = icon
	# if get_parent().name == "GuildShop":
	# 	$Button.disabled = $HSlider.value == 0 || (input_handler.active_faction.reputation - (cost / $HSlider.step) * $HSlider.value) < 0
	# if get_parent().name in ["AreaShop", "GuildShop"]:
	# 	$ItemPrice.text = "x " + str($HSlider.value * (cost / $HSlider.step))
	$ItemAmount.text = "x " + str($HSlider.value)
#	$ItemName.text = showntext

func confirm_number_selection():
	target_node.call(target_function, $HSlider.value / $HSlider.step)
	hide()

func change_number_selection(value):
	update()
