
var data = {
	mages_introduction1 = {
		image = null,
		character = 'myr',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "MAGESINTRODUCTION1", reqs = [], previous_dialogue_option = 1},
		],
		options = [
		{code = 'mages_introduction2', text = "MAGESINTRODUCTION1REPLY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},
	mages_introduction2 = {
		image = null,
		character = 'myr',
		tags = ['dialogue_scene','master_translate'],
		text = [
		{text = "MAGESINTRODUCTION2", reqs = [], previous_dialogue_option = 1},
		],
		options = [
		{code = 'mages_introduction3', text = "MAGESINTRODUCTION2REPLY", reqs = [], dialogue_argument = 1, type = 'next_dialogue'},
		],
	},

	mages_join = {
		image = null,
		character = 'myr',
		tags = ['dialogue_scene'],
		text = [
		{text = "MAGESJOIN", reqs = []},
		],
		common_effects = [{code = 'reputation', name = 'mages', operant = '+', value = 100},
		{code = 'make_loot', pool = [['mages_join_reward',1]]}, 
		{code = 'open_loot'}
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), type = 'next_dialogue',bonus_effects = [{code = 'create_character', type = 'mages'}, {code = 'progress_quest', value = 'guilds_introduction', stage = 'stage1'},{code = 'progress_quest', value = 'guilds_introduction', stage = 'stage1'},{code = "update_guild"}]},
		]
	},
	mages_leader_close = {
		image = null,
		character = 'myr',
		tags = ['dialogue_scene'],
		text = [
		{text = "MAGESCLOSE1", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start'}]},
		{text = "MAGESCLOSE2", reqs = [{type = 'active_quest_stage', value = 'guilds_introduction', stage = 'start', state = false}]},
		],
		options = [
		{code = 'close', reqs = [], text = tr("DIALOGUECLOSE"), bonus_effects = [{code = "update_guild"}]},
		]
	},
	mages_questions = {
		image = null,
		character = 'myr',
		tags = ['dialogue_scene'],
		text = [
		{text = "MAGESQUESTIONS_1", reqs = [], previous_dialogue_option = 1},
		{text = "MAGESQUESTIONS_2", reqs = [], previous_dialogue_option = 2},
		{text = "MAGESQUESTIONS_3", reqs = [], previous_dialogue_option = 3},
		{text = "MAGESQUESTIONS_4", reqs = [], previous_dialogue_option = 4},
		{text = "MAGESQUESTIONS_5", reqs = [], previous_dialogue_option = 5},
		],
		options = [
		{code = 'mages_questions', text = "MAGESQUESTIONREPLY1", reqs = [], dialogue_argument = 2, remove_after_first_use = true},
		{code = 'mages_questions', text = "MAGESQUESTIONREPLY2", reqs = [], dialogue_argument = 3, remove_after_first_use = true},
		{code = 'mages_questions', text = "MAGESQUESTIONREPLY3", reqs = [], dialogue_argument = 4, remove_after_first_use = true},
		{code = 'mages_questions', text = "MAGESQUESTIONREPLY4", reqs = [{type = 'dialogue_seen', check = true, value = 'MAGESQUESTIONS_4'}], dialogue_argument = 5, remove_after_first_use = true},
		{code = 'mages_introduction3', text = "MAGESASKQUESTIONSRETURN", reqs = [], dialogue_argument = 3},
		],
		
	},
	
	mages_election1 = { 
		image = null,
		character = 'myr',
		tags = ['dialogue_scene'],
		text = [
		{text = "MAGESELECTION1", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'start'}]},
		],
		options = [
		{code = 'mages_election2', text = "MAGESELECTION1REPLY1", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
		{code = 'mages_election2', text = "MAGESELECTION1REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 2}
		],
	},
	
	mages_election2 = { 
		image = null,
		character = 'myr',
		tags = ['dialogue_scene'],
		text = [
		{text = "MAGESELECTION2_1", reqs = [], previous_dialogue_option = 1},
		{text = "MAGESELECTION2_2", reqs = [], previous_dialogue_option = 2},
		{text = "MAGESELECTION2_ANY", reqs = []}
		],
		options = [
		{code = 'mages_election3', text = "MAGESELECTION2REPLY1", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
		{code = 'mages_election3', text = "MAGESELECTION2REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 2}
		],
	},
	
	mages_election3 = { 
		image = null,
		character = 'myr',
		tags = [],
		text = [
		{text = "MAGESELECTION3_1", reqs = [], previous_dialogue_option = 1},
		{text = "MAGESELECTION3_2", reqs = [], previous_dialogue_option = 2},
		{text = "MAGESELECTION3_ANY", reqs = [],}
		],
		options = [
		{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = [], bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'start'}, {code = 'make_quest_location', value = 'quest_mages_xari'}]}
		],
	},
	
	mages_election4 = {
		variations = [
		{reqs = [{type = 'decision', value = 'slept_with_xari', check = true}],
		image = null,
		character = 'myr',
		tags = ['dialogue_scene'],
		text = [{text = "MAGESELECTION4_1", reqs = [], bonus_effects = [{code = 'complete_quest', value = 'mages_election_quest'}]}],
		options = [
		{code = 'mages_election5', text = "MAGESELECTION4_1REPLY1", reqs = [], bonus_effects = [
			{code = 'decision', value = 'mages_election_support'}], type = 'next_dialogue', dialogue_argument = 1},
		{code = 'mages_election5', text = "MAGESELECTION4_1REPLY2", reqs = [], bonus_effects = [
			{code = 'decision', value = 'mages_election_support'}], type = 'next_dialogue', dialogue_argument = 2},
		{code = 'mages_election5', text = "MAGESELECTION4_1REPLY3", reqs = [], bonus_effects = [
			{code = 'decision', value = 'mages_election_support'}], type = 'next_dialogue', dialogue_argument = 3},
		],
		},
		{reqs = [],
		image = null,
		character = 'myr',
		tags = [],
		text = [{text = "MAGESELECTION4_2", reqs = [], bonus_effects = [{code = 'complete_quest', value = 'mages_election_quest'}]}],
		options = [
		{code = 'close', text = tr("DIALOGUELEAVE"), reqs = [], 
		bonus_effects = [{code = 'decision', value = 'mages_election_support'}],}
		],
		},
		],
	},
	
	mages_election5 = {
		image = null,
		tags = [],
		character = 'myr',
		text = [
		{text = "MAGESELECTION5", reqs = []}
		],
		options = [
		{code = 'leave', text = tr("DIALOGUELEAVE"), reqs = [], }
		],
	},
	
	# Xari Encounter
	xari_encounter1 = {
		image = null,
		scene_type = "unlocked_gallery_seq",
		unlocked_gallery_seq = "xari_encounter",
		save_scene_to_gallery = true,
		tags = ['dialogue_scene'],
		character = 'xari',
		text = [
			{text = "XARIENCOUNTER1", reqs = []}
		],
		options = [
			{code = 'xari_encounter2', text = "XARIENCOUNTER1REPLY1", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'xari_encounter2', text = "XARIENCOUNTER1REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 2},
		]
	},

	xari_encounter2 = {
		image = null,
		character = 'xari',
		tags = ['dialogue_scene'],
		text = [
			{text = "XARIENCOUNTER2_1", reqs = [], previous_dialogue_option = 1},
			{text = "XARIENCOUNTER2_2", reqs = [], previous_dialogue_option = 2},
		],
		options = [
			{code = 'xari_encounter3', text = "XARIENCOUNTER2REPLY1", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'xari_encounter3', text = "XARIENCOUNTER2REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'xari_encounter3', text = "XARIENCOUNTER2REPLY3", reqs = [], type = 'next_dialogue', dialogue_argument = 3},
		]
	},

	xari_encounter3 = {
		image = null,
		character = 'xari',
		tags = ['dialogue_scene'],
		text = [
			{text = "XARIENCOUNTER3_1", reqs = [], previous_dialogue_option = 1},
			{text = "XARIENCOUNTER3_2", reqs = [], previous_dialogue_option = 2},
			{text = "XARIENCOUNTER3_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{code = 'xari_encounter4', text = "XARIENCOUNTER3REPLY1", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'xari_encounter4', text = "XARIENCOUNTER3REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'xari_encounter4', text = "XARIENCOUNTER3REPLY3", reqs = [], type = 'next_dialogue', dialogue_argument = 3},
		]
	},

	xari_encounter4 = {
		image = null,
		character = 'xari',
		tags = ['dialogue_scene'],
		text = [
			{text = "XARIENCOUNTER4_1", reqs = [], previous_dialogue_option = 1},
			{text = "XARIENCOUNTER4_2", reqs = [], previous_dialogue_option = 2},
			{text = "XARIENCOUNTER4_3", reqs = [], previous_dialogue_option = 3},
		],
		options = [
			{code = 'xari_encounter5', text = "XARIENCOUNTER4REPLY1", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'xari_encounter5', text = "XARIENCOUNTER4REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'xari_encounter5', text = "XARIENCOUNTER4REPLY3", reqs = [], type = 'next_dialogue', dialogue_argument = 3},
		]
	},

	xari_encounter5 = {
		image = null,
		character = 'xari',
		tags = ['dialogue_scene'],
		text = [
			{text = "XARIENCOUNTER5_1", reqs = [], previous_dialogue_option = 1},
			{text = "XARIENCOUNTER5_2", reqs = [], previous_dialogue_option = 2},
			{text = "XARIENCOUNTER5_3", reqs = [], previous_dialogue_option = 3},
			{text = "XARIENCOUNTER5_ANY", reqs = []},
		],
		options = [
			{code = 'xari_encounter6', text = "XARIENCOUNTER5REPLY1", reqs = [{type = 'dialogue_seen', check = true, value = 'XARIENCOUNTER4_3'}], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'xari_encounter7', text = "XARIENCOUNTER5REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'xari_ecnounter_apprentice', text = "XARI_ENCOUNTER_APPRENTICE_OPTION", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'apprentice', check = true}]}], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'xari_encounter5', disabled = true, text = "SPECIAL_ACTION_CLASS", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'apprentice', check = false}]}], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'close', text = "XARIENCOUNTER5REPLY3", reqs = [], type = 'next_dialogue', dialogue_argument = 3, bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'stage1'}]},
		]
	},

	xari_encounter6 = {
		image = null,
		character = 'xari',
		tags = ['dialogue_scene'],
		text = [
			{text = "XARIENCOUNTER6", reqs = []},
		],
		options = [
			{code = 'xari_encounter7', text = "XARIENCOUNTER5REPLY2", reqs = [], type = 'next_dialogue', dialogue_argument = 1},
			{code = 'xari_ecnounter_apprentice', text = "XARI_ENCOUNTER_APPRENTICE_OPTION", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'apprentice', check = true}]}], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'xari_encounter6', disabled = true, text = "SPECIAL_ACTION_CLASS", reqs = [{type = 'master_check', value = [{code = 'has_profession', profession = 'apprentice', check = false}]}], type = 'next_dialogue', dialogue_argument = 2},
			{code = 'close', text = "XARIENCOUNTER5REPLY3", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'stage1'}]},
		]
	},
	
	xari_ecnounter_apprentice = {
		image = null,
		character = 'xari',
		tags = ['master_translate'],
		text = [
			{text = "XARI_ENCOUNTER_APPRENTICE", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'stage2'}]}
		],
		options = [
			{code = 'close', text = tr("DIALOGUECLOSE"), reqs = []}
		]
	},
	
	xari_encounter7 = {
		variations = [
			{image = null,
			character = 'xari',
			tags = ['dialogue_scene'],
			text = [{text = "XARIENCOUNTER7_1", reqs = []}],
			reqs = [{type = 'master_check', value = [{code = 'one_of_races', value = ['Elf', 'TribalElf', 'DarkElf']}, {code = 'sex', operant = 'neq', value = 'female'}]}],
			options = [
				{code = 'xari_encounter8', text = tr("DIALOGUECONTINUE"), reqs = [], type = 'next_dialogue', dialogue_argument = 1, change_dialogue_type = 2},
			]
		},
			{image = null,
			character = 'xari',
			tags = ['dialogue_scene'],
			text = [{text = "XARIENCOUNTER7_2", reqs = []}], 
			reqs = [{type = 'master_check', value = [{code = 'sexuals_factor', operant = 'gte', value = 4}, {code = 'sex', operant = 'neq', value = 'female'}]}],
			options = [
				{code = 'xari_encounter8', text = tr("DIALOGUECONTINUE"), reqs = [], type = 'next_dialogue', dialogue_argument = 1, change_dialogue_type = 2},
			]
		},
			{image = null,
			character = 'xari',
			tags = [],
			text = [{text = "XARIENCOUNTER7_3", reqs = []}], 
			reqs = [{type = 'master_check', value = [{code = 'sex', operant = 'eq', value = 'female'}]}],
			options = [
				{code = 'close', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'stage1'}, {code = "update_location"}]},
			]
		},
			{image = null,
			character = 'xari',
			tags = ['dialogue_scene'],
			text = [{ text = "XARIENCOUNTER7_4", reqs = [] }],
			reqs = [{type = 'master_check', value = [{code = 'sexuals_factor', operant = 'lt', value = 4}]}],
			options = [
				{code = 'close', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = "update_location"}]},
			]
		},
	],
	},

	xari_encounter8 = {
		image = null,
		custom_background = "xari_encounter8",
		scene_type = "ero_scene",
		save_scene_to_gallery = true,
#		dialogue_type = 2,
#		character = 'xari',
		tags = ['dialogue_scene'],
		text = [
			{text = "XARIENCOUNTER8_1", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'sexuals_factor', operant = 'gte', value = 3}]}]},
			{text = "XARIENCOUNTER8_2", reqs = [{type = 'master_check', value = [{code = 'stat', stat = 'sexuals_factor', operant = 'lt', value = 3}]}]},
			{text = "XARIENCOUNTER8_3", reqs = []},
		],
		options = [
			{code = 'close' , text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'stage2'}, {code = 'screen_black_transition', value = 1}, {code = 'decision', value = 'slept_with_xari'}]}
		]
	},

	xari_encounter9 = {
		image = null,
		character = 'xari',
		tags = ['dialogue_scene'],
		text = [
			{text = "XARIENCOUNTER9", reqs = []},
		],
		options = [# Fix Reqs
			{code = 'xari_encounter10', text = "XARIENCOUNTER9REPLY1",
			reqs = [
				{type = "location_has_specific_slaves", value = 1, location = 'quest_mages_xari', reqs = [
					{code = 'one_of_races', value = ['Elf','TribalElf','DarkElf']}, 
					{code = 'sex', operant = 'neq', value = 'female'}]}], dialogue_argument = 1, type = 'next_dialogue'},
			{code = 'close', text = "XARIENCOUNTER9REPLY2", reqs = []},
		]
	},

	xari_encounter10 = {
		image = null,
		character = 'xari',
		tags = ['master_translate'],
		text = [
			{text = "XARIENCOUNTER10", reqs = [], bonus_effects = [{code = 'progress_quest', value = 'mages_election_quest', stage = 'stage2'}]}
		],
		options = [
			{code = 'close', text = tr("DIALOGUECLOSE"), reqs = [], bonus_effects = []}
		]
	},
}

