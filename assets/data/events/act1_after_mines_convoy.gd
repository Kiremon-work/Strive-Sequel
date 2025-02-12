extends Reference
var data = {
	after_mines_sigmund_start = {
		variations = [ {
				reqs = [{type = 'decision', value = 'SaveRebels', check = true}],
				image = null, tags = ['dialogue_scene'], character = "sigmund",
				text = [{text = "AFTER_MINES_SIGMUND_START", reqs = []}],
				common_effects = [{code = 'money_change', operant = '+', value = 300}],
				options = [ {
				code = 'after_mines_sigmund_1',
				text = "AFTER_MINES_SIGMUND_OPTION_1", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
				}, {
				code = 'after_mines_sigmund_1',
				text = "AFTER_MINES_SIGMUND_OPTION_2", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
				} ],
			}, {
				reqs = [{type = 'decision', value = 'SaveRebels', check = false}],
				image = null, tags = ['dialogue_scene'], character = "sigmund",
				text = [{text = "AFTER_MINES_SIGMUND_3", reqs = []}],
				options = [ {
					code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
					bonus_effects = [{code = 'progress_quest', value = 'civil_war_mines', stage = 'stage4'}], #adds option on sigmund introduction
				} ],
			},
		]
	},

	after_mines_sigmund_1 = {
		image = null, tags = ['dialogue_scene'], character = "sigmund",
		text = [{text = "AFTER_MINES_SIGMUND_1", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_MINES_SIGMUND_2", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 2, type = 'next_dialogue',
			bonus_effects = [{code = 'progress_quest', value = 'civil_war_mines', stage = 'stage4'}],
		} ],
	},

	after_mines_duncan_start = {
		image = null, tags = ['dialogue_scene'], character = "duncan",
		text = [{text = "AFTER_MINES_DUNCAN_1", reqs = [], previous_dialogue_option = 8},
		{text = "AFTER_MINES_DUNCAN_2", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_MINES_DUNCAN_5", reqs = [], previous_dialogue_option = 4},
		{text = "AFTER_MINES_DUNCAN_6", reqs = [], previous_dialogue_option = 5},
		{text = "AFTER_MINES_DUNCAN_7", reqs = [], previous_dialogue_option = 6}],
		options = [ {
			code = 'after_mines_duncan_start', text = "AFTER_MINES_DUNCAN_OPTION_1", reqs = [], dialogue_argument = 1
		}, {
			code = 'after_mines_duncan_1', text = "AFTER_MINES_DUNCAN_OPTION_2", reqs = [], dialogue_argument = 2, remove_after_first_use = true
		}, {
			code = 'after_mines_duncan_2', text = "AFTER_MINES_DUNCAN_OPTION_3", reqs = [
				{type = 'dialogue_selected', check = true, value = 'AFTER_MINES_DUNCAN_OPTION_1'},
			{type = 'dialogue_selected', check = true, value = 'AFTER_MINES_DUNCAN_OPTION_2'}, ], dialogue_argument = 3, type = 'next_dialogue'
		} ],
	},

	after_mines_duncan_1 = {
		variations = [ {
				reqs = [{type = 'decision', value = 'SaveRebels', check = false}],
				image = null, tags = ['dialogue_scene'], character = "duncan",
				text = [{text = "AFTER_MINES_DUNCAN_3_4", reqs = []}],
				common_effects = [{code = 'money_change', operant = '+', value = 500}],
				options = [ {
				code = 'after_mines_duncan_start',
				text = "AFTER_MINES_DUNCAN_OPTION_4", reqs = [], dialogue_argument = 4
				}, {
				code = 'after_mines_duncan_start',
				text = "AFTER_MINES_DUNCAN_OPTION_5", reqs = [], dialogue_argument = 5
				}, {
				code = 'after_mines_duncan_start',
				text = "AFTER_MINES_DUNCAN_OPTION_6", reqs = [], dialogue_argument = 6
				} ],
			}, {
				reqs = [{type = 'decision', value = 'SaveRebels', check = true}],
				image = null, tags = ['dialogue_scene'], character = "duncan",
				text = [{text = "AFTER_MINES_DUNCAN_1", reqs = [], previous_dialogue_option = 8},
				{text = "AFTER_MINES_DUNCAN_2", reqs = [], previous_dialogue_option = 1},
				{text = "AFTER_MINES_DUNCAN_5", reqs = [], previous_dialogue_option = 4},
				{text = "AFTER_MINES_DUNCAN_6", reqs = [], previous_dialogue_option = 5},
				{text = "AFTER_MINES_DUNCAN_7", reqs = [], previous_dialogue_option = 6},
				{text = "AFTER_MINES_DUNCAN_3", reqs = [], previous_dialogue_option = 2}],
				options = [ {
					code = 'after_mines_duncan_start', text = "AFTER_MINES_DUNCAN_OPTION_1", reqs = [], dialogue_argument = 1
				}, {
					code = 'after_mines_duncan_2', text = "AFTER_MINES_DUNCAN_OPTION_3", reqs = [
						{type = 'dialogue_selected', check = true, value = 'AFTER_MINES_DUNCAN_OPTION_1'},
					{type = 'dialogue_selected', check = true, value = 'AFTER_MINES_DUNCAN_OPTION_2'}, ], dialogue_argument = 3
				} ],
			},
		]
	},

	after_mines_duncan_2 = {
		image = null, tags = ['dialogue_scene'], character = "duncan",
		text = [{text = "AFTER_MINES_DUNCAN_8", reqs = []}],
		options = [ {
			code = 'after_mines_duncan_3', text = "AFTER_MINES_DUNCAN_OPTION_7", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		},  {
			code = 'after_mines_duncan_3', text = "AFTER_MINES_DUNCAN_OPTION_8", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		},  {
			code = 'after_mines_duncan_3', text = "AFTER_MINES_DUNCAN_OPTION_9", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		},  ],
	},

	after_mines_duncan_3 = {
		image = null, tags = ['dialogue_scene'], character = "duncan",
		text = [{text = "AFTER_MINES_DUNCAN_9", reqs = []}],
		common_effects = [{code = 'add_timed_event', value = "after_mines_message", args = [{type = 'add_to_date', date = [4,4], hour = 1}]}],
		options = [ {
			code = 'close', text = "AFTER_MINES_DUNCAN_OPTION_10", reqs = [], dialogue_argument = 2, bonus_effects = [{code = 'complete_quest', value = 'civil_war_mines'}]
		},  {
			code = 'close', text = "AFTER_MINES_DUNCAN_OPTION_11", reqs = [], dialogue_argument = 2, bonus_effects = [{code = 'complete_quest', value = 'civil_war_mines'}]
		},  {
			code = 'close', text = "AFTER_MINES_DUNCAN_OPTION_12", reqs = [], dialogue_argument = 2, bonus_effects = [{code = 'complete_quest', value = 'civil_war_mines'}]
		},  ],
	},

	after_mines_message = {
		common_effects = [{code = 'progress_quest', value = 'lead_convoy_quest', stage = 'stage1'}],
		image = 'letter', tags = ['dialogue_scene'],
		text = [{text = "AFTER_MINES_MESSAGE", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 2,
			bonus_effects = [{code = 'rewrite_save'}], 
		}],
	},

	after_mines_duncan_4 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "duncan",
		text = [{text = "AFTER_MINES_DUNCAN_10", reqs = []}],
		options = [ {
			code = 'after_mines_duncan_5', text = "AFTER_MINES_DUNCAN_OPTION_14", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}, {
			code = 'after_mines_duncan_5', text = "AFTER_MINES_DUNCAN_OPTION_15", master_translate = true, reqs = [], dialogue_argument = 2, type = 'next_dialogue'
		} ],
	},

	after_mines_duncan_5 = {
		image = null, tags = ['dialogue_scene'], character = "duncan",
		text = [{text = "AFTER_MINES_DUNCAN_11", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_MINES_DUNCAN_12", reqs = [], previous_dialogue_option = 2}],
		common_effects = [{code = 'progress_quest', value = 'lead_convoy_quest', stage = 'stage2'}, {code = "update_guild"}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	after_mines_convoy_1 = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "AFTER_MINES_CONVOY_1", reqs = []}],
		options = [ {
			code = 'after_mines_convoy_2', text = "AFTER_MINES_CONVOY_OPTION_1", reqs = [], dialogue_argument = 1,type = 'next_dialogue'
		}, {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 2
		}, ],
	},

	after_mines_convoy_2 = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "AFTER_MINES_CONVOY_2", reqs = []}],
		options = [ {
			code = 'after_mines_convoy_fight', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, bonus_effects = [{code = 'return_to_mansion'}], type = 'next_dialogue'
		}, {
			code = 'close', text = "DIALOGUELEAVE", reqs = [], dialogue_argument = 2
		}, ],
	},

	after_mines_convoy_fight = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "AFTER_MINES_CONVOY_3", reqs = []}],
		options = [ {
			code = 'quest_fight', args = 'rebel_convoy',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		} ],
	},

	rebel_convoy_win = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "AFTER_MINES_CONVOY_4", reqs = []}],
		options = [ {
			code = 'after_mines_convoy_3', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	after_mines_convoy_3 = {
		image = 'refugees', tags = ['dialogue_scene'],
		text = [{text = "AFTER_MINES_CONVOY_5", reqs = []}],
		options = [ {
			code = 'after_mines_convoy_4', text = "AFTER_MINES_CONVOY_OPTION_2", reqs = [], dialogue_argument = 1,
			bonus_effects = [{code = 'decision', value = 'SiegeLostSupplies'}], type = 'next_dialogue'
		}, {
			code = 'after_mines_convoy_4', text = "AFTER_MINES_CONVOY_OPTION_3", reqs = [], dialogue_argument = 2,
			bonus_effects = [{code = 'decision', value = 'SiegeHalfSupplies'}], type = 'next_dialogue'
		},
		#{code = 'after_mines_convoy_4', text = "AFTER_MINES_CONVOY_HUNTER_OPTION", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'hunter', check = true}]}], dialogue_argument = 4, type = 'next_dialogue'},
		{
			code = 'after_mines_convoy_4', text = "AFTER_MINES_CONVOY_OPTION_4", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
		}, ],
	},

	after_mines_convoy_4 = {
		image = 'refugees', tags = ['dialogue_scene', 'master_translate'],
		text = [ {text = "AFTER_MINES_CONVOY_6", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_MINES_CONVOY_7", reqs = [], previous_dialogue_option = 2},
		{text = "AFTER_MINES_CONVOY_8", reqs = [], previous_dialogue_option = 3},
		{text = "AFTER_MINES_CONVOY_HUNTER", reqs = [], previous_dialogue_option = 4} ],
		options = [{
			bonus_effects = [{code = 'teleport_active_location', to_loc = {location = 'settlement_plains1', code = 'settlement_plains1', area = 'plains'}},
			{code = 'set_location_param', location = 'settlement_plains1', area = 'plains', param = 'captured', value = false},
			{code = 'set_location_param', location = 'settlement_plains1', area = 'plains', param = 'locked', value = true}],
			code = 'after_mines_convoy_5', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		}],
	},

	duncan_not_found = {
		image = null, tags = ['dialogue_scene'],
		text = [ {text = "DUNCAN_NOT_FOUND", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 4
		}],
	},

	after_mines_convoy_5 = {
		variations = [ {
				reqs = [{type = 'decision', value = 'SiegeLostSupplies', check = false},
				{type = 'decision', value = 'SiegeHalfSupplies', check = false}],
				image = null, tags = ['dialogue_scene', 'master_translate'], character = "duncan",
				text = [{text = "AFTER_MINES_CONVOY_9", reqs = []}, {text = "AFTER_MINES_CONVOY_13", reqs = []},],
				options = [ {
				code = 'after_mines_convoy_7',
				text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
				} ]
			}, {
				reqs = [],
				image = null, tags = ['dialogue_scene', 'master_translate'], character = "duncan",
				text = [{text = "AFTER_MINES_CONVOY_9", reqs = []}, {text = "AFTER_MINES_CONVOY_10", reqs = []},],
				options = [ {
				code = 'after_mines_convoy_6',
				text = "AFTER_MINES_CONVOY_OPTION_5", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
				}, {
				code = 'after_mines_convoy_6',
				text = "AFTER_MINES_CONVOY_OPTION_6", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
				} ]
			}
		],
	},

	after_mines_convoy_6 = {
		image = null, tags = ['dialogue_scene', 'master_translate'], character = "duncan",
		text = [{text = "AFTER_MINES_CONVOY_11", reqs = [], previous_dialogue_option = 1},
		{text = "AFTER_MINES_CONVOY_12", reqs = [], previous_dialogue_option = 2}],
		options = [ {
			code = 'after_mines_convoy_7', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	after_mines_convoy_7 = {
		image = null, tags = ['dialogue_scene','blackscreen_transition_common'], character = "aire", character2 = "greg",
		text = [{text = "AFTER_MINES_CONVOY_14", reqs = []}],
		options = [ {
			code = 'after_mines_convoy_8', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	after_mines_convoy_8 = {
		image = null, tags = ['dialogue_scene','blackscreen_transition_common'], character = "duncan", character2 = "anastasia",
		text = [{text = "AFTER_MINES_CONVOY_15", reqs = []}],
		options = [ {
			code = 'after_mines_convoy_9', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	after_mines_convoy_9 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "anastasia",
		text = [{text = "AFTER_MINES_CONVOY_16", reqs = []}],
		options = [ {
			code = 'after_mines_convoy_10', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}],
	},

	after_mines_convoy_10 = {
		image = null, tags = ['dialogue_scene'], character = "duncan", character2 = "anastasia",
		text = [{text = "AFTER_MINES_CONVOY_17", reqs = []}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], dialogue_argument = 1,
			bonus_effects = [
			{code = 'open_location', location = "SETTLEMENT_PLAINS1", area = "plains"},
			{code = 'progress_quest', value = 'lead_convoy_quest', stage = 'stage3'}], type = 'next_dialogue'
		}],
	},
}
