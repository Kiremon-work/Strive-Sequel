extends "res://editor tools/classes/stat_panel.gd"


func _ready():
	$VBoxContainer/index.visible = false
	$VBoxContainer/number.visible = true
	$VBoxContainer/formula.visible = false
	$VBoxContainer/string.visible = false
	$VBoxContainer/reslist.visible = false
	$VBoxContainer/flag.visible = false
	$VBoxContainer/Button.visible = false
	stat_node = $VBoxContainer/number
	stat_node.connect('text_entered', self, 'commit')
#	._ready()

func get_data():
	if !visible: return
	if parent.tres.has(stat):
		var tmp = parent.tres[stat]
		stat_node.text = str(tmp)
	else:
		stat_node.text = ""
