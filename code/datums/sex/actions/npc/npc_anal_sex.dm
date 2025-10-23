/datum/sex_action/npc/npc_anal_sex
	name = "NPC Sodomize them"
	stamina_cost = 0
	check_same_tile = FALSE
	require_grab = FALSE
	hole_id = ORGAN_SLOT_ANUS

/datum/sex_action/npc/npc_anal_sex/shows_on_menu(mob/living/user, mob/living/target)
	return FALSE

/*/datum/sex_action/npc/npc_anal_sex/can_perform(mob/living/user, mob/living/target)
	if(user.seeksfuck) //should filter down to only npcs with seeksfuck behavior.
		return TRUE
	return FALSE*/

/datum/sex_action/npc/npc_anal_sex/on_start(mob/living/user, mob/living/target)
	. = ..()
	user.visible_message(span_warning("[user] slides his cock into [target]'s ass!"))
	playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/datum/sex_action/npc/npc_anal_sex/on_perform(mob/living/user, mob/living/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] fucks [target]'s ass."))
	playsound(target, sex_session.get_force_sound(), 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	sex_session.perform_sex_action(user, 2, 0, TRUE)

	if(sex_session.considered_limp())
		sex_session.perform_sex_action(target, 1.2, 4, FALSE)
	else
		sex_session.perform_sex_action(target, 2.4, 9, FALSE)
	sex_session.handle_passive_ejaculation(target)


/datum/sex_action/npc/npc_anal_sex/handle_climax_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_love("[user] cums into [target]'s butt!"))
	target.virginity = FALSE
	return "into"

/datum/sex_action/npc/npc_anal_sex/on_finish(mob/living/user, mob/living/target)
	. = ..()
	user.visible_message(span_warning("[user] pulls [user.p_their()] cock out of [target]'s butt."))


///datum/sex_action/npc/npc_anal_sex/is_finished(mob/living/user, mob/living/target)
	/*if(user.sexcon.finished_check())
		if(issimple(user))
			var/mob/living/simple_animal/hostile/retaliate/rogue/simpleuser = user
			simpleuser.stoppedfucking(target)
		else
			var/mob/living/carbon/human/humanuser = user
			humanuser.stoppedfucking(target)
		return TRUE
	return FALSE*/
