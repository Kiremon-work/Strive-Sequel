extends Reference
var data = {
	servants_join = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "SERVANTSJOIN",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "reputation",
				name = "servants",
				operant = "+",
				value = 100
			},
			{
				code = "make_loot",
				pool = [
					[
						"servants_join_reward",
						1
					]
				]
			},
			{
				code = "open_loot"
			}
		],
		options = [
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUECLOSE",
				type = "next_dialogue",
				bonus_effects = [
					{
						code = "create_character",
						type = "servants"
					},
					{
						code = "progress_quest",
						value = "guilds_introduction",
						stage = "stage1"
					},
					{
						code = "update_guild"
					}
				]
			}
		]
	},
	servants_leader_close = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "SERVANTSCLOSE1",
				reqs = [
					{
						type = "active_quest_stage",
						value = "guilds_introduction",
						stage = "start"
					}
				]
			},
			{
				text = "SERVANTSCLOSE2",
				reqs = [
					{
						type = "active_quest_stage",
						value = "guilds_introduction",
						stage = "start",
						state = false
					}
				]
			}
		],
		options = [
			{
				code = "close",
				reqs = [

				],
				text = "DIALOGUECLOSE",
				bonus_effects = [
					{
						code = "update_guild"
					}
				]
			}
		]
	},
	servants_questions = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "SERVANTSQUESTIONS_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "SERVANTSQUESTIONS_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "SERVANTSQUESTIONS_3",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "SERVANTSQUESTIONS_4",
				reqs = [

				],
				previous_dialogue_option = 4
			}
		],
		options = [
			{
				code = "servants_questions",
				text = "SERVANTSQUESTIONREPLY1",
				reqs = [

				],
				dialogue_argument = 2,
				remove_after_first_use = true
			},
			{
				code = "servants_questions",
				text = "SERVANTSQUESTIONREPLY2",
				reqs = [

				],
				dialogue_argument = 3,
				remove_after_first_use = true
			},
			{
				code = "servants_questions",
				text = "SERVANTSQUESTIONREPLY3",
				reqs = [

				],
				dialogue_argument = 4,
				remove_after_first_use = true
			},
			{
				code = "servants_introduction",
				text = "SERVANTSASKQUESTIONSRETURN",
				reqs = [

				],
				dialogue_argument = 4
			}
		]
	},
	servants_election = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "SERVANTSELECTIONCONFIRM",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				bonus_effects = [
					{
						code = "decision",
						value = "servants_election_support"
					}
				]
			}
		]
	},
	elections_start1 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "ELECTIONSTART1",
				reqs = [

				],
				previous_dialogue_option = 1
			}
		],
		common_effects = [
			{
				code = "progress_quest",
				value = "election_global_quest",
				stage = "stage1"
			},
			{
				code = "complete_quest",
				value = "guilds_introduction"
			}
		],
		options = [
			{
				code = "elections_start2",
				text = "ELECTIONSTARTREPLY1_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "elections_start2",
				text = "ELECTIONSTARTREPLY1_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	elections_start2 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "ELECTIONSTART2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "elections_start3",
				text = "ELECTIONSTARTREPLY2_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "elections_start3",
				text = "ELECTIONSTARTREPLY2_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	elections_start3 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "ELECTIONSTART3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "elections_persuade",
				text = "ELECTIONSTARTREPLY3_1",
				reqs = [

				],
				dialogue_argument = 1
			},
			{
				code = "elections_start4",
				text = "ELECTIONSTARTREPLY3_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	elections_persuade = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "ELECTIONPERSUADE1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "ELECTIONPERSUADESUCCESS",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "charm_factor",
								operant = "gte",
								value = 3
							}
						]
					}
				],
				previous_dialogue_option = 2
			},
			{
				text = "ELECTIONPERSUADEFAILURE",
				reqs = [
					{
						type = "master_check",
						value = [
							{
								code = "stat",
								stat = "charm_factor",
								operant = "lte",
								value = 2
							}
						]
					}
				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "elections_persuade",
				text = "ELECTIONSTARTREPLY3_2",
				reqs = [
					{
						type = "dialogue_selected",
						check = false,
						value = "ELECTIONSTARTREPLY3_2"
					}
				],
				dialogue_argument = 2
			},
			{
				code = "elections_start4",
				text = "ELECTIONSTARTREPLY3_3",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			}
		]
	},
	elections_start4 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "ELECTIONSTART4",
				reqs = [

				]
			},
			{
				text = "ELECTIONSTART4_1",
				reqs = [
					{
						type = "faction_reputation",
						code = "servants",
						operant = "gte",
						value = 200
					}
				],
				bonus_effects = [
					{
						code = "decision",
						value = "servants_election_support"
					}
				]
			},
			{
				text = "ELECTIONSTART4_2",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "elections_start5",
				text = "ELECTIONSTARTREPLY4_1",
				reqs = [

				],
				dialogue_argument = 1,
				type = "next_dialogue"
			},
			{
				code = "elections_start5",
				text = "ELECTIONSTARTREPLY4_2",
				reqs = [

				],
				dialogue_argument = 2,
				type = "next_dialogue"
			}
		]
	},
	elections_start5 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "ELECTIONSTART5_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "ELECTIONSTART5_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				],
				bonus_effects = [
					{
						code = "update_guild"
					}
				]
			}
		]
	},
	servants_election_finish1 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "SERVANTSELECTIONFINISH1",
				reqs = [

				]
			},
			{
				text = "SERVANTSELECTIONFINISH1_2",
				reqs = [
					{
						type = "has_multiple_decisions",
						decisions = [
							"fighters_election_support",
							"workers_election_support",
							"servants_election_support",
							"mages_election_support"
						],
						operant = "gte",
						value = 4
					}
				],
				bonus_effects = [
					{
						code = "make_loot",
						pool = [
							[
								"servants_election_bonus",
								1
							]
						]
					},
					{
						code = "open_loot"
					}
				]
			},
			{
				text = "SERVANTSELECTIONFINISH1_3",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "complete_quest",
				value = "election_global_quest"
			},
			{
				code = "election_finish"
			},
			{
				code = "check_masters_story_fame"
			},
			{
				code = "add_master_points",
				value = 1
			}
		],
		options = [
			{
				code = "servants_election_finish2",
				text = "SERVANTSELECTIONFINISH1REPLY1",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 1
			},
			{
				code = "servants_election_finish2",
				text = "SERVANTSELECTIONFINISH1REPLY2",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 2
			}
		]
	},
	servants_election_finish2 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "SERVANTSELECTIONFINISH2_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "SERVANTSELECTIONFINISH2_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "servants_election_finish3",
				text = "SERVANTSELECTIONFINISH2REPLY1",
				reqs = [

				],
				dialogue_argument = 3
			},
			{
				code = "servants_election_finish4",
				text = "SERVANTSELECTIONFINISH2REPLY2",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 1
			},
			{
				code = "servants_election_finish4",
				text = "SERVANTSELECTIONFINISH2REPLY3",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 2
			}
		]
	},
	servants_election_finish3 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene",
			"master_translate"
		],
		text = [
			{
				text = "SERVANTSELECTIONFINISH3",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "servants_election_finish4",
				text = "SERVANTSELECTIONFINISH2REPLY2",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 1
			},
			{
				code = "servants_election_finish4",
				text = "SERVANTSELECTIONFINISH2REPLY3",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 2
			}
		]
	},
	servants_election_finish4 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "SERVANTSELECTIONFINISH4_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "SERVANTSELECTIONFINISH4_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "servants_election_finish5",
				text = "SERVANTSELECTIONFINISH4REPLY1",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 1
			},
			{
				code = "servants_election_finish5",
				text = "SERVANTSELECTIONFINISH4REPLY2",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 2
			}
		]
	},
	servants_election_finish5 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "SERVANTSELECTIONFINISH5_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "SERVANTSELECTIONFINISH5_2",
				reqs = [

				],
				previous_dialogue_option = 2
			}
		],
		options = [
			{
				code = "servants_election_finish6",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 1
			}
		]
	},
	servants_election_finish6 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene",
			"blackscreen_transition_common",
			"close_guild"
		],
		text = [
			{
				text = "SERVANTSELECTIONFINISH6",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "servants_election_finish7",
				text = "SERVANTSELECTIONFINISH6REPLY1",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 1
			},
			{
				code = "servants_election_finish7",
				text = "SERVANTSELECTIONFINISH6REPLY2",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 2
			},
			{
				code = "servants_election_finish7",
				text = "SERVANTSELECTIONFINISH6REPLY3",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 3
			}
		]
	},
	servants_election_finish7 = {
		image = null,
		character = "amelia",
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "SERVANTSELECTIONFINISH7_1",
				reqs = [

				],
				previous_dialogue_option = 1
			},
			{
				text = "SERVANTSELECTIONFINISH7_2",
				reqs = [

				],
				previous_dialogue_option = 2
			},
			{
				text = "SERVANTSELECTIONFINISH7_3",
				reqs = [

				],
				previous_dialogue_option = 3
			},
			{
				text = "SERVANTSELECTIONFINISH7_ANY",
				reqs = [

				]
			}
		],
		options = [
			{
				code = "servants_election_finish8",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 1,
				change_dialogue_type = 2
			}
		]
	},
	servants_election_finish8 = {
		variations = [
			{
				reqs = [
					{
						type = "decision",
						value = "aire_is_dead",
						check = false
					}
				],
				image = null,
				custom_background = "anastasia_event_alive",
				common_effects = [
					{
						code = "set_music",
						value = "battle2"
					}
				],
				scene_type = "story_scene",
				save_scene_to_gallery = true,
				dialogue_type = 2,
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "SERVANTSELECTIONFINISH8",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "servants_election_finish9",
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						type = "next_dialogue",
						dialogue_argument = 1
					}
				]
			},
			{
				image = null,
				reqs = [

				],
				custom_background = "anastasia_event_dead",
				common_effects = [
					{
						code = "set_music",
						value = "battle2"
					}
				],
				scene_type = "story_scene",
				save_scene_to_gallery = true,
				dialogue_type = 2,
				tags = [
					"dialogue_scene"
				],
				text = [
					{
						text = "SERVANTSELECTIONFINISH8",
						reqs = [

						]
					}
				],
				options = [
					{
						code = "servants_election_finish9",
						text = "DIALOGUECONTINUE",
						reqs = [

						],
						type = "next_dialogue",
						dialogue_argument = 1
					}
				]
			}
		]
	},
	servants_election_finish9 = {
		tags = [
			"dialogue_scene"
		],
		text = "SERVANTSELECTIONFINISH9",
		options = [
			{
				code = "after_election_line1",
				text = "DIALOGUECONTINUE",
				reqs = [

				],
				type = "next_dialogue",
				dialogue_argument = 1,
				change_dialogue_type = 1,
				close_speed = 2
			}
		],
		common_effects = [
			{
				code = "decision",
				value = "act1_start"
			}
		]
	},
	start_finale = {
		image = null,
		tags = [
			"dialogue_scene"
		],
		text = [
			{
				text = "STARTFINALE",
				reqs = [

				]
			}
		],
		common_effects = [
			{
				code = "set_music",
				value = "ending"
			}
		],
		options = [
			{
				code = "close",
				text = "DIALOGUECLOSE",
				reqs = [

				]
			}
		]
	}
}
