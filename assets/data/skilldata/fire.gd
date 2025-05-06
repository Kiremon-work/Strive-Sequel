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
		effects = [Effectdata.rebuild_template({effect = 'burn', chance = 0.2, duration = 2})], 
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
				set = {effects = [Effectdata.rebuild_template({effect = 'burn', chance = 0.6, duration = 2})]},
				add = {descript = '_1'}
			},
			{
				reqs = [{code = 'stat', stat = 'mastery_fire', value = 5, operant = 'gte'}],
				set = {effects = [Effectdata.rebuild_template({effect = 'burn', duration = 2})]},
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
		effects = [Effectdata.rebuild_template({effect = 'burn', duration = 3})], 
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
		effects = [Effectdata.rebuild_template({effect = 'burn', duration = 4})], 
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
		effects = [Effectdata.rebuild_template({effect = 'darkflame', duration = 4})], 
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
		stack = 'bloodboil',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 4,
		tags = ['buff'],
		statchanges = {atk_add_part = 0.25, resist_stun = 200, resist_wet = 200, resist_fear = 200},
		buffs = [
			{
				icon = "res://assets/images/iconsskills/skill_bloodboil.png",
				description = "TRAITEFFECTBLOODBOIL",
			}
		],
	},
	e_t_fireshield = {
		type = 'temp_s',
		target = 'target',
		stack = 'fireshield',
		tick_event = variables.TR_TURN_F,
		rem_event = [variables.TR_COMBAT_F, variables.TR_DEATH],
		duration = 'arg',
		tags = ['buff'],
		statchanges = {resist_water = 40},
		buffs = [
			{
				icon = "res://assets/images/traits/speeddebuf.png",
				description = "TRAITEFFECTFIRESHIELD",
			}
		],
	}
}
var atomic_effects = {}
var buffs = {}

var stacks = {
	bloodboil = {}, #st1
	fireshield = {}, #st1
}
