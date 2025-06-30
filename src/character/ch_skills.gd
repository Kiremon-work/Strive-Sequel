extends Reference

var parent: WeakRef
var social_skills = []
var social_cooldowns = {}
var social_skills_charges = {}
var combat_skills = []
var explore_skills = []
var combat_skill_charges = {}
var combat_cooldowns = {}
var daily_cooldowns = {}
var social_skill_panel = {}
var combat_skill_panel = {}
var active_panel = variables.PANEL_SOC
var skills_received_today = []

var items_used_global = {}
var items_used_today = {}

var prepared_act = []

func setup_skills(data):
	#attention! counterintuitive naming is for a keeping compartibility with simple fighters templating, where 'skills' are for combat skills
	if data.has('skills'):
		for skill in data.skills:
			learn_c_skill(skill)
	if data.has('civ_skills'):
		for skill in data.civ_skills:
			learn_skill(skill)
	if !combat_skills.has("ranged_attack") and !combat_skills.has('attack'):
		combat_skills.push_back('attack')


func get_damage_mod(skill):
	#stub. needs filling
	if skill.type == 'social': 
		return 1
	var res = parent.get_ref().get_stat('damage_mod_all')
	if skill.target_range == 'melee': 
		res *= parent.get_ref().get_stat('damage_mod_melee')
	if skill.target_range == 'weapon' and parent.get_ref().get_weapon_range() == 'melee': 
		res *= parent.get_ref().get_stat('damage_mod_melee')
	if skill.target_range == 'any': 
		res *= parent.get_ref().get_stat('damage_mod_ranged')
	if skill.target_range == 'weapon' and parent.get_ref().get_weapon_range() == 'any':
		 res *= parent.get_ref().get_stat('damage_mod_ranged')
	if skill.ability_type == 'skill': 
		res *= parent.get_ref().get_stat('damage_mod_skill')
	if skill.ability_type == 'spell': 
		res *= parent.get_ref().get_stat('damage_mod_spell')
	if skill.tags.has('aoe'): 
		res *= parent.get_ref().get_stat('damage_mod_aoe')
	if skill.tags.has('heal') and skill.ability_type != 'item': 
		res *= parent.get_ref().get_stat('damage_mod_heal')
	
	return res


func get_manacost_for_skill(skill):
	var res = 0
	if skill.has('cost') and skill.cost.has('mp'):
		res = skill.cost.mp
	res *= parent.get_ref().get_stat('manacost_mod')
	for st in skill.tags:
		if statdata.statdata.has('manacost_mod_' + st):
			res *= parent.get_ref().get_stat('manacost_mod_' + st)
	return res


func get_value_damage_mod(skill_val):
	#stub. needs filling
	var res = parent.get_ref().get_stat('damage_mod_' + skill_val.damage_type)
	return res


func get_learned_skills(cat):
	match cat:
		'social':
			return social_skills.duplicate()
		'combat':
			return combat_skills.duplicate()
		'explore':
			return explore_skills.duplicate()


func fix_skillpanels(list_soc_add, list_combat_add, list_soc_remove, list_combat_remove):
	for pos in combat_skill_panel.keys().duplicate():
		if combat_skill_panel[pos] in list_combat_remove:
			combat_skill_panel.erase(pos)
	for pos in social_skill_panel.keys().duplicate():
		if social_skill_panel[pos] in list_soc_remove:
			social_skill_panel.erase(pos)

	var pos = 1
	for skill in list_combat_add:
		if combat_skill_panel.values().has(skill):
			continue
		while combat_skill_panel.has(pos):
			pos += 1
		if pos > 21:
			break
		combat_skill_panel[pos] = skill
	pos = 1
	for skill in list_soc_add:
		if social_skill_panel.values().has(skill):
			continue
		while social_skill_panel.has(pos):
			pos += 1
		if pos > 11:
			break
		social_skill_panel[pos] = skill



func learn_skill(skill):
	var skilldata = Skilldata.Skilllist[skill]
	if !social_skills.has(skill):
		social_skills.append(skill)
		parent.get_ref().reset_rebuild()


func learn_c_skill(skill):
	var skilldata = Skilldata.Skilllist[skill]
	if !combat_skills.has(skill):
		combat_skills.append(skill)
		parent.get_ref().reset_rebuild()


func learn_e_skill(skill, free = false):
	var skilldata = Skilldata.Skilllist[skill]
	if !explore_skills.has(skill):
		explore_skills.append(skill)
		parent.get_ref().reset_rebuild()


func unlearn_skill(skill):
	social_skills.erase(skill)
	social_cooldowns.erase(skill)
	daily_cooldowns.erase(skill)
	social_skills_charges.erase(skill)
	for i in range(1,12):
		if social_skill_panel.has(i) and social_skill_panel[i] == skill: social_skill_panel.erase(i)
		parent.get_ref().reset_rebuild()


func unlearn_c_skill(skill):
	combat_skills.erase(skill)
	combat_cooldowns.erase(skill)
	daily_cooldowns.erase(skill)
	for i in range(1,22):
		if combat_skill_panel.has(i) and combat_skill_panel[i] == skill: combat_skill_panel.erase(i)
		parent.get_ref().reset_rebuild()


func unlearn_e_skill(skill):
	explore_skills.erase(skill)
	daily_cooldowns.erase(skill)
	parent.get_ref().reset_rebuild()


func cooldown_tick():
	items_used_today.clear()
	skills_received_today.clear()
	
	for i in ['chg_strength','chg_dexterity','chg_persuasion','chg_wisdom']:
		parent.get_ref().set_stat(i, 0)
	
	var cleararray = []
	for i in social_cooldowns:
		social_cooldowns[i] -= 1
		if social_cooldowns[i] <= 0:
			social_skills_charges.erase(i)
			cleararray.append(i)
	
	for i in cleararray:
		social_cooldowns.erase(i)
	
	for i in daily_cooldowns:
		daily_cooldowns[i] -= 1
		if daily_cooldowns[i] <= 0:
			cleararray.append(i)
			combat_skill_charges.erase(i)
	
	for i in cleararray:
		daily_cooldowns.erase(i)


func reset_cooldowns():
	for skill in combat_cooldowns.keys().duplicate():
		if skill == 'rally':
			continue
		combat_cooldowns.erase(skill)


func skill_tooltip(skillcode): #??
	var text = ''
	var skill = Skilldata.get_template(skillcode, parent.get_ref())
	text += "[center]" + skill.name + "[/center]\n" + skill.descript
	return text


func get_skill_by_tag(tg):
	for s in parent.get_ref().get_combat_skills():
		var s_f = Skilldata.get_template(s, parent.get_ref())
		if s_f.tags.has(tg): return s
	return null


func restore_skill_charge(code):
	if social_skills_charges.has(code):
		social_skills_charges[code] -= 1
		if social_skills_charges[code] <= 0:
			social_cooldowns.erase(code)
			social_skills_charges.erase(code)
	if ResourceScripts.game_party.global_skills_used.has(code):
		ResourceScripts.game_party.global_skills_used[code] -= 1
		if ResourceScripts.game_party.global_skills_used[code] <= 0:
			ResourceScripts.game_party.global_skills_used.erase(code)
	gui_controller.mansion.SkillModule.build_skill_panel()


func use_social_skill(s_code, target, item):
	var template = Skilldata.get_template(s_code, parent.get_ref())
	if template.has('special'):
		item = Items.itemlist[item.itembase]
		if s_code == 'map':
			ResourceScripts.custom_effects.call(template.special, item.map)
		elif s_code == 'skill_granting':
			ResourceScripts.custom_effects.call(template.special, parent.get_ref(), item.skill)
		else:
			ResourceScripts.custom_effects.call(template.special, parent.get_ref())
		return
	if target != null:
		var check = parent.get_ref().check_skill_availability(s_code, target)
		if check.check == false:
			#input_handler.SystemMessage(check.descript)
			globals.text_log_add('skill',check.descript)
			return
	parent.get_ref().add_stat('metrics_socskillused', 1)
	social_cooldowns[s_code] = template.cooldown
	if template.has('social_skill_stats'):
		for i in template.social_skill_stats:
			parent.get_ref().add_stat(i, rand_range(0.4,0.8))
	if template.tags.has("dialogue_skill"):
		var data = {text = '', image = template.dialogue_image, tags = ['skill_event'], options = []}
		var text = parent.get_ref().translate(template.dialogue_text)
		text = target.translate(text.replace("[target", "["))
		data.text = text
		
		var charges = template.charges
		if charges > 0 && ResourceScripts.game_globals.social_skill_unlimited_charges == false:
			if social_skills_charges.has(s_code):
				social_skills_charges[s_code] += 1
			else:
				social_skills_charges[s_code] = 1
		
		if template.has("globallimit"):
			if ResourceScripts.game_party.global_skills_used.has(template.code):
				ResourceScripts.game_party.global_skills_used[template.code] += 1
			else:
				ResourceScripts.game_party.global_skills_used[template.code] = 1
		
		input_handler.active_character = parent.get_ref()
		input_handler.target_character = target
		input_handler.activated_skill = s_code
		for i in template.dialogue_options:
			data.options.append(i)
		if template.ability_type != 'item':
			data.options.append({code = 'cancel_skill_usage', text = "Cancel", reqs = []})
		input_handler.scene_characters.append(target)
		input_handler.interactive_message_custom(data)
		return
	input_handler.last_action_data = {code = 'social_skill', skill = s_code, caster = parent.get_ref(), target = target}
	
	input_handler.PlaySound('page')
	#paying costs
	parent.get_ref().pay_cost(template.cost)
	
	if typeof(template.charges) == TYPE_INT && template.charges > 0 && ResourceScripts.game_globals.social_skill_unlimited_charges == false:
		if social_skills_charges.has(s_code):
			social_skills_charges[s_code] += 1
		else:
			social_skills_charges[s_code] = 1
	
	if template.has("globallimit"):
		if ResourceScripts.game_party.global_skills_used.has(template.code):
			ResourceScripts.game_party.global_skills_used[template.code] += 1
		else:
			ResourceScripts.game_party.global_skills_used[template.code] = 1
	#calcuate 'all' receviers
	var targ_targ = [target]
	var targ_cast = [parent.get_ref()]
	var targ_all = []
	for h_id in ResourceScripts.game_party.characters:
		if parent.get_ref().id == h_id or (target != null and target.id == h_id): 
			continue
		if ResourceScripts.game_party.characters[h_id].get_work() == 'travel':
			continue
		if !parent.get_ref().same_location_with(ResourceScripts.game_party.characters[h_id]):
			continue
		targ_all.push_back(ResourceScripts.game_party.characters[h_id])
	#create s_skill and process triggers
	var s_skill = ResourceScripts.scriptdict.class_sskill.new()
	s_skill.createfromskill(template)
	s_skill.setup_caster(parent.get_ref())
	s_skill.setup_target(target)
	s_skill.process_event(variables.TR_CAST, {skill = s_skill})
	s_skill.setup_final()
	s_skill.hit_roll()
	s_skill.resolve_value(true)
	s_skill.apply_random()
	s_skill.setup_effects_final()
	parent.get_ref().process_event(variables.TR_S_CAST, {skill = s_skill, caster = parent.get_ref(), target = target})
	if target != null:
		target.process_event(variables.TR_S_TARGET, {skill = s_skill, caster = parent.get_ref(), target = target})
	#assumption that no social skill will have more than 1 repeat or target_number 
	#s_skill.calculate_dmg() not really needed
	#to implement not fully described social chance-to-success system 
	var effect_text = '\n'
	#applying values
	for i in s_skill.value:
		if !i.check_conditions(): continue
		var targ_fin
		match i.receiver:
			'caster': targ_fin = targ_cast
			'target': targ_fin = targ_targ
			'all': targ_fin = targ_all
			'area': 
				targ_fin = targ_all.duplicate()
				targ_fin.push_back(parent.get_ref())
				if target != null and target != parent.get_ref():
					targ_fin.push_back(target)
		if i.damagestat == 'no_stat':
			if template.has('process_no_stat'):
				for h in targ_fin:
					s_skill.process_event(variables.TR_SOC_SPEC, {skill = s_skill, caster = parent.get_ref(), target = target, receiver = h})
#					for e in s_skill.effects:
#						var eff:triggered_effect = effects_pool.get_effect_by_id(e)
#						eff.process_act(variables.TR_SOC_SPEC, {skill = s_skill, caster = parent.get_ref(), target = target, receiver = h})
			continue
#		var detail_tags = []
		for h in targ_fin:
			var cached_value = i.value
			var detail_tags = []
			if i.template.has('receiver_reqs'):
				if !h.checkreqs(i.template.receiver_reqs): continue
			var mod = i.dmgf
			var stat = i.damagestat
			var bonusspeech = []
			var tmp
			if stat.begins_with('direct_personality'):
				var cur_personality = h.get_stat('personality')
				var st = stat.trim_prefix('direct_')
				var st_res = st
				if cached_value < 0:
#					cached_value = -cached_value
					if st == 'personality_bold':
						st_res = 'personality_shy'
					else:
						st_res = 'personality_serious'
				h.add_stat(st, cached_value)
				effect_text += "\n" + h.translate(tr("PERSONALITYSHIFT" + st_res.to_upper()))
				
				var next_personality = h.get_stat('personality')
				if next_personality != cur_personality:
					effect_text += "\n" + h.get_short_name() + tr("PERSONALITYCHANGE") + tr("PERSONALITYNAME" + next_personality.to_upper())
				parent.get_ref().update_prt()
			elif stat.begins_with('personality'):
				if h.check_work_rule("personality_lock"):
					continue
				var cur_personality = h.get_stat('personality')
				var tres = {personality_bold = 0, personality_shy = 0, personality_kind = 0,personality_serious = 0} #2 per stat
				if mod == 1:
					cached_value = -cached_value
				var update_data = h.change_personality_stats(stat.trim_prefix('personality_'), cached_value, parent.get_ref().has_status('communicative'))
				var change = update_data[0]
				var stats_bind = ['personality_bold', 'personality_bold']
				if stat == 'personality_bold':
					if change[0] > 0:
						stats_bind[0] = 'personality_bold'
					else:
						stats_bind[0] = 'personality_shy'
						change[0] = - change[0]
					if change[1] > 0:
						stats_bind[1] = 'personality_kind'
					else:
						stats_bind[1] = 'personality_serious'
						change[1] = - change[1]
				elif stat == 'personality_kind':
					if change[1] > 0:
						stats_bind[1] = 'personality_bold'
					else:
						stats_bind[1] = 'personality_shy'
						change[1] = - change[1]
					if change[0] > 0:
						stats_bind[0] = 'personality_kind'
					else:
						stats_bind[0] = 'personality_serious'
						change[0] = - change[0]
				
				for ii in [0, 1]:
					tres[stats_bind[ii]] = change[ii]
				
				if update_data[1] == true:
					effect_text += globals.TextEncoder(h.translate(tr("PERSONALITYREBEL")))
				for st in tres:
					if tres[st] == 0: 
						continue
					
					effect_text += "\n" + h.translate(tr("PERSONALITYSHIFT"+st.to_upper()))# + h.get_short_name() + ", " + statdata.statdata[st].name + ": +" + str(tres[st])
				var next_personality = h.get_stat('personality')
				if next_personality != cur_personality:
					effect_text += "\n" + h.get_short_name() + tr("PERSONALITYCHANGE") + tr("PERSONALITYNAME" + next_personality.to_upper())
				parent.get_ref().update_prt()
			else:
				match mod:
					0:
						tmp = h.stat_update(stat, cached_value)
						if stat  == 'lust':
							if h.get_stat('lust') >= h.get_stat('lustmax'):
								detail_tags.append('lust_cap')
						if i.is_drain > 0.0: 
							parent.get_ref().stat_update(stat, -tmp * i.is_drain)
					1:
						tmp = h.stat_update(stat, -cached_value)
						if i.is_drain > 0.0: 
							parent.get_ref().stat_update(stat, -tmp * i.is_drain)
					2:
						tmp = h.stat_update(stat, cached_value, true)
						if i.is_drain > 0.0: 
							parent.get_ref().stat_update(stat, -tmp * i.is_drain)

				effect_text += "\n" + h.get_short_name() + ", " + statdata.statdata[stat].name
			
				var maxstat = 100
				if i.damagestat.find("factor")>=0:
					maxstat = 0
				elif statdata.statdata.has(stat+'max'):
					maxstat = h.get_stat(stat + "max")
				
				var change = '+'
				if tmp < 0:
					change = ''
				effect_text += ": "
				if maxstat != 0 && !(stat in ['consent', 'lust', 'base_exp']):
					effect_text += str(floor(h.get_stat(stat))) +"/" + str(floor(maxstat)) +  " (" + change + "" + str(floor(tmp)) + ("(%d)" % cached_value) +  ")"
				else:
					effect_text += change + str(floor(tmp)) 
				if detail_tags.has("lust_cap") && stat == 'lust':
					effect_text += " - Maxed"
			for j in bonusspeech:
				effect_text += "\n\n{color=aqua|"+ h.get_short_name() + "} - {random_chat=0|"+ j +"}\n"
	if target != null and target.skills.skills_received_today.has(s_code) == false: target.skills.skills_received_today.append(s_code)
	
	if template.has("dialogue_report"):
		var data = {text = '', tags = ['skill_report_event'], options = []}
		var text = parent.get_ref().translate(template.dialogue_report)
		if template.has('dialogue_image'):
			data.image = template.dialogue_image
		else:
			data.image = 'noevent'
		if target != null: text = target.translate(text.replace("[target", "["))
		data.text = text + effect_text
		
		if template.dialogue_show_repeat == true:
			data.options.append({code ='repeat', text = tr('DIALOGUEREPEATACTION'), disabled = true, reqs = []})
			if parent.get_ref().check_skill_availability(s_code, target).check == true:
				data.options[0].disabled = false
		
		input_handler.active_character = parent.get_ref()
		input_handler.target_character = target
		input_handler.activated_skill = s_code
		if input_handler.scene_characters.has(target) == false: input_handler.scene_characters.append(target)
		
		data.options.append({code = 'close', text = tr("DIALOGUECLOSE"), reqs = []})
		
		input_handler.interactive_message_custom(data)
	#postdamage triggers
	s_skill.process_event(variables.TR_POSTDAMAGE, {skill = s_skill, caster = parent.get_ref(), target = target})
	parent.get_ref().process_event(variables.TR_POSTDAMAGE, {skill = s_skill, caster = parent.get_ref(), target = target})
	if target != null:
		target.process_event(variables.TR_POSTDAMAGE, {skill = s_skill, caster = parent.get_ref(), target = target})
	else:
		for t in targ_all: t.process_event(variables.TR_POSTDAMAGE, {skill = 's_skill', caster = parent.get_ref(), target = target})
	
	input_handler.update_slave_list()
	#input_handler.update_slave_panel()

func use_mansion_item(item):
	var itembase = Items.itemlist[item.itembase]
	var skill = itembase.mansion_effect
	if parent.get_ref().checkreqs(itembase.reqs) == false:
		input_handler.SystemMessage(tr(itembase.reqs_fail_message))
		return
	if itembase.has("uses_per_target") && items_used_global.has(itembase.code) && items_used_global[itembase.code] >= itembase.uses_per_target:
		input_handler.SystemMessage(parent.get_ref().translate("[name] can't use this item anymore."))
		return
	elif itembase.has("uses_per_target"):
		if items_used_global.has(itembase.code):
			items_used_global[itembase.code] += 1
		else:
			items_used_global[itembase.code] = 1
	if itembase.tags.has("save_on_use") == false:
		item.amount -= 1
	use_social_skill(skill, parent.get_ref(), item)


func act_prepared():
	for prep in prepared_act:
		use_social_skill(prep, null, null)
	prepared_act.clear()


func repair_skill_panels():
	var ssp = social_skill_panel.duplicate()
	social_skill_panel.clear()
	for i in ssp:
		if Skilldata.Skilllist.has(ssp[i]):
			social_skill_panel[int(i)] = ssp[i]
	ssp = combat_skill_panel.duplicate()
	combat_skill_panel.clear()
	for i in ssp:
		if Skilldata.Skilllist.has(ssp[i]):
			combat_skill_panel[int(i)] = ssp[i]
	var cleararray = []
	for i in [social_skills, combat_skills]:
		for k in i:
			if Skilldata.Skilllist.has(k) == false:
				cleararray.append(k)
	for i in cleararray:
		for k in [social_skills, combat_skills]:
			k.erase(i)
