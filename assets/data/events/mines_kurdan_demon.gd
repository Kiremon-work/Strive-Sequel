var data = {
	pre_final_boss_start = {
		variations = [ {
			reqs = [{type = 'decision', value = 'KurdanFollowing', check = true}],
			image = null, tags = ['dialogue_scene'], character = "demon_female",
			text = [ {text = "PRE_FINAL_BOSS_START", reqs = [], previous_dialogue_option = 0},
			{text = "PRE_FINAL_BOSS_1", reqs = [], previous_dialogue_option = 1},
			{text = "PRE_FINAL_BOSS_2_2", reqs = [], previous_dialogue_option = 2}],
			options = [ {
				code = 'pre_final_boss_start',
				text = "PRE_FINAL_BOSS_OPTION_1", reqs = [], dialogue_argument = 1
			}, {
				code = 'pre_final_boss_start',
				text = "PRE_FINAL_BOSS_OPTION_2", reqs = [], dialogue_argument = 2
			}, {
				code = 'pre_final_boss_1',
				text = "PRE_FINAL_BOSS_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			} ]
		},
			{
			reqs = [{type = 'decision', value = 'KurdanFollowing', check = false}],
			image = null, tags = ['dialogue_scene'], character = "demon_female",
			text = [ {text = "PRE_FINAL_BOSS_START", reqs = [], previous_dialogue_option = 0},
			{text = "PRE_FINAL_BOSS_1", reqs = [], previous_dialogue_option = 1},
			{text = "PRE_FINAL_BOSS_2_1", reqs = [], previous_dialogue_option = 2}],
			options = [ {
				code = 'pre_final_boss_start',
				text = "PRE_FINAL_BOSS_OPTION_1", reqs = [], dialogue_argument = 1
			}, {
				code = 'pre_final_boss_start',
				text = "PRE_FINAL_BOSS_OPTION_2", reqs = [], dialogue_argument = 2
			}, {
				code = 'pre_final_boss_1',
				text = "PRE_FINAL_BOSS_OPTION_3", reqs = [], dialogue_argument = 3, type = 'next_dialogue'
			}
			],
			}
		]
	},

	pre_final_boss_1 = {
		image = null, tags = ['dialogue_scene'], character = "demon_female",
		text = [{text = "PRE_FINAL_BOSS_3", reqs = [], previous_dialogue_option = 3}],
		options = [ {
			code = 'pre_final_boss_2',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 1, type = 'next_dialogue'
		}
		],
	},

	pre_final_boss_2 = {
		image = null, tags = ['dialogue_scene'], character = "demon_female",
		text = [{text = "PRE_FINAL_BOSS_4", reqs = []}],
		options = [ {
			code = 'pre_final_boss_agree',
			text = "PRE_FINAL_BOSS_OPTION_4", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		}, {
			code = 'pre_final_boss_refuse',
			text = "PRE_FINAL_BOSS_OPTION_5", reqs = [], dialogue_argument = 5, type = 'next_dialogue'
		}, {
			code = 'pre_final_boss_paladin_knight',
			text = "PRE_FINAL_BOSS_KNIGHT_OPTION", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'knight', check = true}]}], dialogue_argument = 6, type = 'next_dialogue',
		}, {
			code = 'pre_final_boss_paladin_knight',
			text = "PRE_FINAL_BOSS_PALADIN_OPTION", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'paladin', check = true}]}], dialogue_argument = 6, type = 'next_dialogue',
		}, {
			code = 'pre_final_boss_2', disabled = true,
			text = "SPECIAL_ACTION_CLASS", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'knight', check = false}]},
			{type = 'master_check', value = [{code = 'has_profession', profession = 'paladin', check = false}]}], dialogue_argument = 6, type = 'next_dialogue',
		}
		],
	},

	pre_final_boss_paladin_knight = {
		variations = [ { # has Kurdan and Paladin = fight demon
				reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'paladin', check = true}]},
				{type = 'master_check', value = [{code = 'has_profession', profession = 'knight', check = true}], orflag = true},
				{type = 'decision', value = 'KurdanFollowing', check = true}],
				image = null, tags = ['dialogue_scene', 'master_translate'], character = "demon_female", character2 = "kurdan",
				text = [{text = "PRE_FINAL_BOSS_PALADIN_KNIGHT", reqs = []}],
				options = [ {
				code = 'quest_fight', args = 'demon', type = 'next_dialogue', bonus_effects = [{code = 'decision', value = 'SaveRebels'}, {code = 'decision', value = 'KurdanKnightPaladinRoute'}],
				text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 6
				} ],
			}, { #has Kurdan, NOT paladin = fight demon_kurdan
				reqs = [{type = 'decision', value = 'KurdanFollowing', check = true}],
				image = null, tags = ['dialogue_scene', 'master_translate'], character = "demon_female", character2 = "kurdan",
				text = [{text = "PRE_FINAL_BOSS_8", reqs = []}],
				options = [ {
				code = 'pre_final_boss_5', bonus_effects = [{code = 'decision', value = 'SaveRebels'}], #We didn't kill nor let demon take rebels
				text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 6, type = 'next_dialogue'
				} ],
			}, { #NO Kurdan = fight demon
				reqs = [{type = 'decision', value = 'KurdanFollowing', check = false}],
				image = null, tags = ['dialogue_scene'], character = "demon_female",
				text = [{text = "PRE_FINAL_BOSS_10", reqs = []}],
				options = [ {
				code = 'quest_fight', args = 'demon', type = 'next_dialogue', bonus_effects = [{code = 'decision', value = 'SaveRebels'}],
				text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 6
				} ],
			}
		]
	},

	pre_final_boss_agree = {
		variations = [ {
				reqs = [{type = 'decision', value = 'KurdanFollowing', check = true}],
				image = null, tags = ['dialogue_scene'], character = "demon_female",
				text = [{text = "PRE_FINAL_BOSS_5", reqs = []}],
				options = [ {
				code = 'pre_final_boss_4',
				text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 6
				} ],
			}, {
				reqs = [{type = 'decision', value = 'KurdanFollowing', check = false}],
				image = null, tags = ['dialogue_scene'], character = "demon_female",
				text = [{text = "PRE_FINAL_BOSS_5", reqs = []}],
				options = [ {
				code = 'pre_final_boss_3',
				text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 6
				} ],
			},
		]
	},

	pre_final_boss_3 = {
		image = null, tags = ['dialogue_scene'],
		text = [{text = "PRE_FINAL_BOSS_7", reqs = []}],
		options = [ {
			code = 'quest_fight', args = 'rebel_group', type = 'next_dialogue',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 6
		} ],
	},

	# Kurdan leaves
	pre_final_boss_4 = {
		image = null, character = "kurdan", tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "PRE_FINAL_BOSS_6", reqs = []}],
		options = [ {
			code = 'pre_final_boss_3',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 6, type = 'next_dialogue'
		} ],
	},

	pre_final_boss_refuse = {
		variations = [ {
				reqs = [{type = 'decision', value = 'KurdanFollowing', check = true}],
				image = null, tags = ['dialogue_scene', 'master_translate'], character = "demon_female", character2 = "kurdan",
				text = [{text = "PRE_FINAL_BOSS_8", reqs = []}],
				options = [ {
				code = 'pre_final_boss_5', bonus_effects = [{code = 'decision', value = 'SaveRebels'}], #We didn't kill nor let demon take rebels
				text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 6, type = 'next_dialogue'
				} ],
			}, {
				reqs = [{type = 'decision', value = 'KurdanFollowing', check = false}],
				image = null, tags = ['dialogue_scene'], character = "demon_female",
				text = [{text = "PRE_FINAL_BOSS_10", reqs = []}],
				options = [ {
				code = 'quest_fight', args = 'demon', type = 'next_dialogue', bonus_effects = [{code = 'decision', value = 'SaveRebels'}],
				text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 6
				} ],
			},
		]
	},

	#fight demon-kurdan
	pre_final_boss_5 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [{text = "PRE_FINAL_BOSS_9", reqs = []}], character = "demon_female",
		options = [ {
			code = 'quest_fight', args = 'demon_kurdan', type = 'next_dialogue',
			text = "DIALOGUEFIGHTOPTION", reqs = [], dialogue_argument = 6
		} ],
	},

	rebel_group_win = {
		image = null, tags = [],
		text = [ {text = "PRE_FINAL_BOSS_11", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], bonus_effects = [{code = 'set_completed_active_location'}, {code = 'progress_quest', value = 'civil_war_mines', stage = 'stage3'}],
			}
		],
	},

	demon_win = {
		image = null, character = "demon_female", tags = ['dialogue_scene'],
		text = [ {text = "PRE_FINAL_BOSS_12", reqs = []} ],
		options = [ {
			code = 'pre_final_boss_8', text = "DIALOGUECONTINUE", reqs = [{type = 'decision', value = 'KurdanKnightPaladinRoute', check = false}], dialogue_argument = 0, type = 'next_dialogue'
			}, {
			code = 'demon_kurdan_win_2', text = "DIALOGUECONTINUE", reqs = [{type = 'decision', value = 'KurdanKnightPaladinRoute', check = true}], dialogue_argument = 1, type = 'next_dialogue'
			}, 
		],
	},

	demon_kurdan_win = {
		image = null, character = "demon_female", tags = ['dialogue_scene'],
		text = [ {text = "PRE_FINAL_BOSS_12", reqs = []} ],
		options = [ {
			code = 'demon_kurdan_win_2', text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 2, type = 'next_dialogue'
			}
		],
	},

	demon_kurdan_win_2 = {
		image = null, character = "kurdan", tags = ['dialogue_scene'],
		text = [ {text = "PRE_FINAL_BOSS_13", reqs = [{type = 'decision', value = 'KurdanKnightPaladinRoute', check = false}]},
		 {text = "PRE_FINAL_BOSS_PALADIN_KNIGHT_WIN_KURDAN", reqs = [{type = 'decision', value = 'KurdanKnightPaladinRoute', check = true}]}, ],
		options = [ {
			code = 'pre_final_boss_6',
			text = "PRE_FINAL_BOSS_OPTION_6", reqs = [], dialogue_argument = 6, type = 'next_dialogue'
		}, {
			code = 'pre_final_boss_7',
			text = "PRE_FINAL_BOSS_OPTION_7", reqs = [], dialogue_argument = 7, type = 'next_dialogue'
		}, {
			code = 'pre_final_boss_7',
			text = "PRE_FINAL_BOSS_OPTION_8", reqs = [], dialogue_argument = 8, type = 'next_dialogue'
		}
		],
	},

	pre_final_boss_6 = {
		image = null, character = "kurdan", tags = ['dialogue_scene'],
		text = [ {text = "PRE_FINAL_BOSS_14", reqs = []} ],
		common_effects = [{code = 'make_story_character', value = 'Kurdan', recruit_from_location = true, send_to_mansion = true}],
		options = [ {
			code = 'pre_final_boss_8',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		} ],
	},

	pre_final_boss_7 = {
		image = null, character = "kurdan", tags = ['dialogue_scene'],
		text = [ {text = "PRE_FINAL_BOSS_15", reqs = [], previous_dialogue_option = 7},
		 {text = "PRE_FINAL_BOSS_16", reqs = [], previous_dialogue_option = 8} ],
		options = [ {
			code = 'pre_final_boss_8',
			text = "DIALOGUECONTINUE", reqs = [], dialogue_argument = 4, type = 'next_dialogue'
		} ],
	},

	pre_final_boss_8 = {
		image = null, tags = ['dialogue_scene', 'master_translate'],
		text = [ {text = "PRE_FINAL_BOSS_17", reqs = []} ],
		options = [ {
			code = 'pre_final_boss_fin_1',
			text = "PRE_FINAL_BOSS_OPTION_9", reqs = [], dialogue_argument = 9, type = 'next_dialogue'
		}, {
			code = 'pre_final_boss_fin_2',
			text = "PRE_FINAL_BOSS_OPTION_10", reqs = [], dialogue_argument = 10, type = 'next_dialogue'
		} ],
	},

	pre_final_boss_fin_1 = {
		image = null, tags = [],
		text = [ {text = "PRE_FINAL_BOSS_18", reqs = []} ],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], type = 'next_dialogue', bonus_effects = [{code = 'set_completed_active_location'}, {code = 'progress_quest', value = 'civil_war_mines', stage = 'stage3'}]
			}
		],
	},

	pre_final_boss_fin_2 = {
		image = null, tags = [],
		text = [ {text = "PRE_FINAL_BOSS_19", reqs = []} ],
		common_effects = [{code = 'make_loot', pool = [['rebels_ore_reward',1]]}, {code = 'open_loot'}],
		options = [ {
			code = 'close', text = "DIALOGUECLOSE", reqs = [], type = 'next_dialogue', bonus_effects = [{code = 'set_completed_active_location'}, {code = 'progress_quest', value = 'civil_war_mines', stage = 'stage3'}]
			}
		],
	},
}
