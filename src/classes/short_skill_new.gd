extends Reference
#class_name S_Skill

var code
var template

var type

var ability_type
var tags
var value = []
var cost
var target_range
var target_number
var number_rnd_targets = 0
#var damagesrc
var repeat

var chance
var evade
var critchance
var armor_p
var caster
var target
var hit_res

var effects = []
var pval_i
var process_value
var random_factor
var random_factor_p
var critmod = 1.0
var tempdur

var sskill_value = ResourceScripts.scriptdict.class_sskill_value 

var keep_target = variables.TARGET_FORCED
var next_target = variables.NT_MELEE

func _init():
	caster = null
	target = null
	target_range = 'any'
	target_number = 'single'
	cost = {}
	random_factor = 0
	random_factor_p = 0.0
	repeat = 1

func clone():
	var res = dict2inst(inst2dict(self))
	res.effects = []
	for e in template.effects:
		var eff = effects_pool.e_createfromtemplate(e, res)
		res.apply_effect(effects_pool.add_effect(eff))
	res.value = []
	for v in value:
		res.value.push_back(v.clone())
	for v in res.value: 
		v.set_parent(res)
	return res

func get_from_template(attr):
	if template.has(attr):
		if typeof(template[attr]) == TYPE_ARRAY:
			set(attr, template[attr].duplicate())
			return
		set(attr, template[attr])

func createfromskill(temp):
	template = temp.duplicate(true)
	code = template.code
	type = template.type
	ability_type = template.ability_type
	tags = template.tags.duplicate()
	cost = template.cost.duplicate()
	get_from_template('target_range')
	get_from_template('target_number')
	get_from_template('number_rnd_targets')
	if number_rnd_targets is Array:
		number_rnd_targets = globals.rng.randi_range(number_rnd_targets[0], number_rnd_targets[1])
	
	get_from_template('keep_target')
	get_from_template('next_target')
	
	for e in template.effects:
		var eff = effects_pool.e_createfromtemplate(e, self)
		apply_effect(effects_pool.add_effect(eff))
	
	repeat = template.repeat
	
	pval_i = 0
	if !template.has('value') or typeof(template.value) != TYPE_ARRAY: return
	for v in range(template.value.size()): 
		value.push_back(sskill_value.new(self, template.value[v]))
		if value[v].template.is_process: pval_i = v


func process_check(check:Array):
	var op1 = check[0]
	var op2 = check[2]
	if op1 == 'damage_type':
		if check[1] == 'eq':
			for val in value:
				if val.damage_type == op2: return true
			return false
		elif check[1] == 'neq':
			for val in value:
				if val.damage_type == op2: return false
			return true
	elif typeof(op1) == TYPE_STRING:
		op1 = get(op1)
#	if typeof(op2) == TYPE_STRING && check[1] != 'has':
#		op2 = get(op2)
	return input_handler.operate(check[1], op1, op2)

func setup_caster(c):
	caster = c
	if type == 'combat' and c!= null:
		if ability_type == 'spell':
			chance = 100
		else:
			chance = caster.get_stat('hitrate')
		critchance = caster.get_stat('critchance')
		critmod = caster.get_stat('critmod')
		armor_p = caster.get_stat('armorpenetration')
		if target_range == 'weapon':
			target_range = caster.get_weapon_range()
	else:
		chance = 100
		critchance = 0
		armor_p = 0
	setup_weapon_element()

func setup_target(t):
	target = t
	if t == null: return
	if type == 'combat':
		if ability_type == 'spell':
			evade = 0
		else:
			evade = target.get_stat('evasion')
	else:
		evade = 0

func setup_final():
	get_from_template('chance')
	if typeof(chance) == TYPE_ARRAY:
		chance = input_handler.calculate_number_from_string_array(chance, caster, target)
	get_from_template('evade')
	if typeof(evade) == TYPE_ARRAY:
		evade = input_handler.calculate_number_from_string_array(evade, caster, target)
	get_from_template('armor_p')
	if typeof(armor_p) == TYPE_ARRAY:
		armor_p = input_handler.calculate_number_from_string_array(armor_p, caster, target)
	get_from_template('critchance')
	if typeof(critchance) == TYPE_ARRAY:
		critchance = input_handler.calculate_number_from_string_array(critchance, caster, target)
	if target == null or caster.combatgroup == target.combatgroup:
		critchance = 0
	if template.has('custom_duration'):
		tempdur = input_handler.calculate_number_from_string_array(template.custom_duration, caster, target)


func hit_roll():#not implemented various chance stat rolls due to not having formulaes
	if type == 'social':
		hit_res = variables.RES_HIT
		return
	var prop = chance - evade
	if (!target.can_evade()): 
		prop = 100 #target can not evade
	if (caster != null) and (caster.combatgroup == target.combatgroup): 
		prop = 100 #targeting ally
	if prop < 5: 
		prop = 5
	if prop < randf()*100:
		hit_res = variables.RES_MISS
	elif critchance < randf()*100:
		hit_res = variables.RES_HIT
	else:
		hit_res = variables.RES_CRIT

func apply_atomic(tmp):
	if tmp.has('stat') and tmp.stat in ['value', 'is_drain', 'cap']:
		for i in range(value.size()):
			value[i].apply_atomic(tmp)
		return
	match tmp.type:
		'stat_add':
			set(tmp.stat, get(tmp.stat) + tmp.value)
		'stat_mul':
			set(tmp.stat, get(tmp.stat) * tmp.value)
		'stat_set':
			set(tmp.stat, tmp.value)
		'add_tag':
			tags.push_back(tmp.value)


func apply_effect(eff):
	var obj = effects_pool.get_effect_by_id(eff)
	match obj.template.type:
		'trigger':
			effects.push_back(obj.id)
			obj.apply()
		'oneshot':
			obj.applied_obj = self
			obj.apply()


func remove_effects():
	for e in effects:
		var eff = effects_pool.get_effect_by_id(e)
		eff.remove()

func process_event(ev, data = {}):
	for e in effects:
		var eff = effects_pool.get_effect_by_id(e)
		eff.process_act(ev, data)

func resolve_value(check_m):
	for v in value: v.resolve_value(check_m)
	process_value = value[pval_i].value

func setup_effects_final():
	process_value = value[pval_i].value
	if template.has('custom_duration'):
		for e in effects:
			var eff = effects_pool.get_effect_by_id(e)
			eff.set_args('duration', tempdur)

func calculate_dmg():
	for v in value: v.calculate_dmg()

func apply_random():
	for v in value: v.apply_random()


func setup_weapon_element():
	for v in value: v.setup_weapon_element()
