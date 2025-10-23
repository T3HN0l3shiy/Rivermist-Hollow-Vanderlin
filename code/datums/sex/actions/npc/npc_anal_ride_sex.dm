/datum/sex_action/npc
	abstract_type = /datum/sex_action/npc
	check_same_tile = FALSE
	check_incapacitated = FALSE
	target_priority = 100
	user_priority = 100
	requires_hole_storage = FALSE

/datum/sex_action/npc/npc_anal_ride_sex
	name = "NPC Ride them anally"
	stamina_cost = 0
	check_same_tile = FALSE
	hole_id = ORGAN_SLOT_ANUS

/datum/sex_action/npc/npc_anal_ride_sex/shows_on_menu(mob/living/user, mob/living/target)
	return FALSE

/*/datum/sex_action/npc/npc_anal_ride_sex/can_perform(mob/living/user, mob/living/target)
	. = ..()
	if(user.seeksfuck) //should filter down to only npcs with seeksfuck behavior.
		return TRUE
	return FALSE*/

/datum/sex_action/npc/npc_anal_ride_sex/on_start(mob/living/user, mob/living/target)
	. = ..()
	user.visible_message(span_warning("[user] gets on top of [target] and begins riding them with their ass!"))
	playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)


/datum/sex_action/npc/npc_anal_ride_sex/on_perform(mob/living/user, mob/living/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] rides [target]."))
	playsound(target, sex_session.get_force_sound(), 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	if(sex_session.considered_limp(target))
		sex_session.perform_sex_action(target, 1.2, 4, TRUE)
	else
		sex_session.perform_sex_action(target, 2.4, 9, TRUE)
	sex_session.handle_passive_ejaculation()

	sex_session.perform_sex_action(user, 2, 4, FALSE)

/datum/sex_action/npc/npc_anal_ride_sex/handle_climax_message(mob/living/carbon/human/user, mob/living/carbon/human/target)
	target.visible_message(span_love("[target] cums into [user]'s butt!"))
	target.virginity = FALSE
	return "into"

/datum/sex_action/npc/npc_anal_ride_sex/on_finish(mob/living/user, mob/living/target)
	. = ..()
	user.visible_message(span_warning("[user] gets off [target]."))


///datum/sex_action/npc/npc_anal_ride_sex/is_finished(mob/living/user, mob/living/target)
	/*if(user.sexcon.finished_check())
		if(issimple(user))
			var/mob/living/simple_animal/hostile/retaliate/rogue/simpleuser = user
			simpleuser.stoppedfucking(target)
		else
			var/mob/living/carbon/human/humanuser = user
			humanuser.stoppedfucking(target)
		return TRUE
	return FALSE*/
