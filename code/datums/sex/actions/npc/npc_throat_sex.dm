/datum/sex_action/npc/npc_throat_sex
	name = "NPC Fuck their throat"
	stamina_cost = 0
	check_same_tile = FALSE

/datum/sex_action/npc/npc_throat_sex/shows_on_menu(mob/living/user, mob/living/target)
	return FALSE

/*/datum/sex_action/npc/npc_throat_sex/can_perform(mob/living/user, mob/living/target)
	if(user.seeksfuck) //should filter down to only npcs with seeksfuck behavior.
		return TRUE
	return FALSE*/

/datum/sex_action/npc/npc_throat_sex/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] fucks [target]'s throat."))
	playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	sex_session.perform_sex_action(user, 2, 0, TRUE)

	if(sex_session.considered_limp(user))
		sex_session.perform_sex_action(target, 0, 2, FALSE)
	else
		sex_session.perform_sex_action(target, 0, 7, FALSE)
	sex_session.handle_passive_ejaculation()

/datum/sex_action/npc/npc_throat_sex/handle_climax_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_love("[user] cums into [target]'s throat!"))
	return "into"


/datum/sex_action/npc/npc_throat_sex/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] pulls [user.p_their()] cock out of [target]'s throat."))


///datum/sex_action/npc/npc_throat_sex/is_finished(mob/living/user, mob/living/target)
	/*if(user.sexcon.finished_check())
		if(issimple(user))
			var/mob/living/simple_animal/hostile/retaliate/rogue/simpleuser = user
			simpleuser.stoppedfucking(target)
		else
			var/mob/living/carbon/human/humanuser = user
			humanuser.stoppedfucking(target)

		return TRUE
	return FALSE*/
