/datum/sex_action/npc/npc_cunnilingus
	name = "NPC Suck their cunt off"
	stamina_cost = 0
	check_same_tile = FALSE
	hole_id = BODY_ZONE_PRECISE_MOUTH
	gags_user = TRUE


/datum/sex_action/npc/npc_cunnilingus/shows_on_menu(mob/living/user, mob/living/target)
	return FALSE

/*/datum/sex_action/npc/npc_cunnilingus/can_perform(mob/living/user, mob/living/target)
	if(user.seeksfuck) //should filter down to only npcs with seeksfuck behavior.
		return TRUE
	return FALSE*/

/datum/sex_action/npc/npc_cunnilingus/on_start(mob/living/user, mob/living/target)
	. = ..()
	user.visible_message(span_warning("[user] starts licking [target]'s cunt..."))

/datum/sex_action/npc/npc_cunnilingus/on_perform(mob/living/user, mob/living/target)
	. = ..()
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] sucks [target]'s clit..."))
	user.make_sucking_noise()
	do_thrust_animate(user, target)

	sex_session.perform_sex_action(target, 2, 3, TRUE)

/datum/sex_action/npc/npc_cunnilingus/handle_climax_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	target.visible_message(span_love("[target] cums into [user]'s mouth!"))
	return "into"


/datum/sex_action/npc/npc_cunnilingus/on_finish(mob/living/user, mob/living/target)
	. = ..()
	user.visible_message(span_warning("[user] stops sucking [target]'s clit ..."))


/datum/sex_action/npc/npc_cunnilingus/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	sex_locks |= new /datum/sex_session_lock(target, ORGAN_SLOT_VAGINA)
	sex_locks |= new /datum/sex_session_lock(user, BODY_ZONE_PRECISE_MOUTH)

///datum/sex_action/npc/npc_cunnilingus/is_finished(mob/living/user, mob/living/target)
	/*if(target.sexcon.finished_check())
		if(issimple(user))
			var/mob/living/simple_animal/hostile/retaliate/rogue/simpleuser = user
			simpleuser.stoppedfucking(target)
		else
			var/mob/living/carbon/human/humanuser = user
			humanuser.stoppedfucking(target)

		return TRUE
	return FALSE*/
