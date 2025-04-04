extends Reference

var skills = {
	firearr = {
		code = 'firearr',
		descript = '',
		icon = "res://assets/images/iconsskills/firebolt.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads','fire'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_burn_new', chance = 0.2, push_characters = true, duration = 2})], 
		cost = {mp = 3},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'firebolt', target = 'target', period = 'predamage'},{code = 'flame', target = 'target', period = 'postdamage'}], 
		sounddata = {initiate = 'firebolt', strike = null, hit = 'firehit', hittype = 'absolute'},
		value = 1.0,
		variations = [
			{
				reqs = [
					{code = 'stat', stat = 'mastery_fire', value = 3, operant = 'gte'},
					{code = 'stat', stat = 'mastery_fire', value = 5, operant = 'lt'},
				],
				set = {effects = [Effectdata.rebuild_template({effect = 'e_s_burn_new', chance = 0.6, push_characters = true, duration = 2})]},
				add = {descript = '_1'}
			},
			{
				reqs = [{code = 'stat', stat = 'mastery_fire', value = 5, operant = 'gte'}],
				set = {effects = [Effectdata.rebuild_template({effect = 'e_s_burn_new', push_characters = true, duration = 2})]},
				add = {descript = '_2'}
			},
		]
	},
	bloodboil = {
		code = 'bloodboil',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_bloodboil.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['support', 'buff', 'fire'],
		reqs = [],
		targetreqs = [],
		effects = ['e_s_bloodboil'], 
		cost = {mp = 4},
		charges = 0,
		combatcooldown = 1,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'fire',#not sure but not matters
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
	},
	fire_shield = {
		code = 'fire_shield',
		descript = '',
		icon = load("res://assets/images/iconsskills/shield_fire.png"),
		type = 'combat', 
		ability_type = 'spell',
		tags = ['support', 'buff', 'fire'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_t_fireshield', duration = 5})], 
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'ally',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'fire',#not sure but not matters
		sfx = [{code = 'heal', target = 'target', period = 'predamage'}],
		sounddata = {initiate = null, strike = 'skill_scene', hit = null},
		value = [['0']],
		damagestat = ['no_stat'],
		variations = [
			{
				reqs = [
					{code = 'stat', stat = 'mastery_fire', value = 5, operant = 'eq'},
					],
				set = {target_number = 'line'},
				add = {descript = '_1'}
			},
			{
				reqs = [{code = 'stat', stat = 'mastery_fire', value = 6, operant = 'gte'}],
				set = {target_number = 'all'},
				add = {descript = '_2'}
			},
		]
	},
	magma_blast = {
		code = 'magma_blast',
		descript = '',
		icon = "res://assets/images/iconsskills/skill_magma blast.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads','fire'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_shatter', duration = 5})], 
		cost = {mp = 8},
		charges = 0,
		combatcooldown = 0,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'flame', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = 'firebolt', strike = null, hit = 'firehit', hittype = 'absolute'},
		value = 1.5
	},
	inferno = {
		code = 'inferno',
		descript = '',
		icon = "res://assets/images/iconsskills/FireBomb.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads','fire', 'aoe'],
		reqs = [],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_burn_new', push_characters = true, duration = 3})], 
		cost = {mp = 15},
		charges = 0,
		combatcooldown = 5,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'flame', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = 'firebolt', strike = null, hit = 'firehit', hittype = 'absolute'},
		value = 1.6,
	},
	
	meteor = {
		code = 'meteor',
		descript = '',
		icon = "res://assets/images/iconsskills/firebolt.png", #fix
		type = 'combat', 
		ability_type = 'spell',
		tags = ['damage','ads','fire'],
		reqs = [
			{code = 'stat', stat = 'mastery_fire', value = 4, operant = 'gte'},
			{code = 'stat', stat = 'mastery_earth', value = 5, operant = 'gte'},
		],
		targetreqs = [],
		effects = [Effectdata.rebuild_template({effect = 'e_s_burn_new', push_characters = true, duration = 4})], 
		cost = {mp = 25},
		charges = 0,
		combatcooldown = 0,
		cooldown = 5,
		catalysts = {},
		target = 'enemy',
		target_number = 'single',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'flame', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = 'firebolt', strike = null, hit = 'firehit', hittype = 'absolute'},
		value = 2.0,
	},
	
	dark_flame = {
		code = 'dark_flame',
		descript = '',
		icon = "res://assets/images/iconsskills/dark flame.png",
		type = 'combat', 
		ability_type = 'spell',
		tags = ['ads','aoe', 'fire'],
		reqs = [
			{code = 'stat', stat = 'mastery_fire', value = 5, operant = 'gte'},
			{code = 'stat', stat = 'mastery_dark', value = 3, operant = 'gte'},
		],
		targetreqs = [
			{code = 'has_status', status = 'burn', check = true},
		],
		effects = [Effectdata.rebuild_template({effect = 'e_s_darkflame', push_characters = true, duration = 4})], 
		cost = {mp = 10},
		charges = 0,
		combatcooldown = 3,
		cooldown = 0,
		catalysts = {},
		target = 'enemy',
		target_number = 'all_allowed',
		target_range = 'any',
		damage_type = 'fire',
		sfx = [{code = 'flame', target = 'target', period = 'predamage'}], 
		sounddata = {initiate = 'firebolt', strike = null, hit = 'firehit', hittype = 'absolute'},
		value = [['0']],
		damagestat = ['no_stat'],
	},
}
var effects = {
	e_s_bloodboil = {
		type = 'trigger',
		trigger = [variables.TR_POSTDAMAGE],
		conditions = [],
		req_skill = true,
		args = [], 
		sub_effects = [
			Effectdata.rebuild_remove_effect('fear'),
			Effectdata.rebuild_remove_effect('stun'),
			Effectdata.rebuild_remove_effect('wet'),
			'e_t_bloodboil'
			],
		buffs = []
	},
	e_t_bloodboil = {
		type = 'temp_s',
		target = 'target',
		name = 'bloodboil',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 4,
		stack = 1,
		args = [],
		tags = ['buff'],
		sub_effects = [
			Effectdata.rebuild_stat_bonus('atk', 0.25, null, 'stat_add_p'),
			Effectdata.rebuild_stat_bonus('resist_stun', 200),
			Effectdata.rebuild_stat_bonus('resist_wet', 200),
			Effectdata.rebuild_stat_bonus('resist_fear', 200),
		],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/iconsskills/skill_bloodboil.png",
				description = "TRAITEFFECTBLOODBOIL",
				limit = 1,
				t_name = 'bloodboil'
			}
		],
	},
	e_t_fireshield = {
		type = 'temp_s',
		target = 'target',
		name = 'fireshield',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'parent',
		stack = 1,
		args = [],
		tags = ['buff'],
		sub_effects = [
			Effectdata.rebuild_stat_bonus('resist_water', 40),
		],
		atomic = [],
		buffs = [
			{
				icon = "res://assets/images/traits/speeddebuf.png",
				description = "TRAITEFFECTFIRESHIELD",
				limit = 1,
				t_name = 'fireshield'
			}
		],
	}
}
var atomic_effects = {}
var buffs = {}
