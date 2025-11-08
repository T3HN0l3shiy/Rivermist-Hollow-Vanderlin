/datum/sex_action/npc/npc_rimming
	name = "NPC Rim them"
	stamina_cost = 0
	check_same_tile = FALSE
	gags_user = TRUE

/datum/sex_action/npc/npc_rimming/shows_on_menu(mob/living/user, mob/living/target)
	return FALSE

/*/datum/sex_action/npc/npc_rimming/can_perform(mob/living/user, mob/living/target)
	if(user.seeksfuck) //should filter down to only npcs with seeksfuck behavior.
		return TRUE
	return FALSE*/

/datum/sex_action/npc/npc_rimming/on_start(mob/living/user, mob/living/target)
	. = ..()
	user.visible_message(span_warning("[user] starts rimming [target]'s butt..."))

/datum/sex_action/npc/npc_rimming/on_perform(mob/living/user, mob/living/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] rims [target]'s butt..."))
	user.make_sucking_noise()
	do_thrust_animate(user, target)

	sex_session.perform_sex_action(target, 2, 0, TRUE)
	sex_session.handle_passive_ejaculation(target)

/datum/sex_action/npc/npc_rimming/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	user.visible_message(span_warning("[user] stops rimming [target]'s butt ..."))

/datum/sex_action/npc/npc_rimming/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	sex_locks |= new /datum/sex_session_lock(user, BODY_ZONE_PRECISE_MOUTH)
	sex_locks |= new /datum/sex_session_lock(target, ORGAN_SLOT_ANUS)



///datum/sex_action/npc/npc_rimming/is_finished(mob/living/user, mob/living/target)
	/*if(target.sexcon.finished_check())
		if(issimple(user))
			var/mob/living/simple_animal/hostile/retaliate/rogue/simpleuser = user
			simpleuser.stoppedfucking(target)
		else
			var/mob/living/carbon/human/humanuser = user
			humanuser.stoppedfucking(target)
		return TRUE
	return FALSE*/
