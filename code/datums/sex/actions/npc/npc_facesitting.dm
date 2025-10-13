/datum/sex_action/npc/npc_facesitting
	name = "NPC Sit on their face with cunt"
	stamina_cost = 0
	check_same_tile = FALSE

/datum/sex_action/npc/npc_facesitting/shows_on_menu(mob/living/user, mob/living/target)
	return FALSE

/*/datum/sex_action/npc/npc_facesitting/can_perform(mob/living/user, mob/living/target)
	if(user.seeksfuck) //should filter down to only npcs with seeksfuck behavior.
		return TRUE
	return FALSE*/


/datum/sex_action/npc/npc_facesitting/on_start(mob/living/user, mob/living/target)
	. = ..()
	user.visible_message(span_warning("[user] sits their butt on [target]'s face!"))


/datum/sex_action/npc/npc_facesitting/on_perform(mob/living/user, mob/living/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	var/verbstring = pick(list("rubs", "smushes", "forces"))
	user.visible_message(sex_session.spanify_force("[user] [sex_session.get_generic_force_adjective()] [verbstring] [user.p_their()] butt against [target] face."))
	target.make_sucking_noise()
	do_thrust_animate(user, target)

	sex_session.perform_sex_action(user, 1, 3, TRUE)
	sex_session.handle_passive_ejaculation()

	sex_session.perform_sex_action(target, 0, 2, FALSE)
	sex_session.handle_passive_ejaculation(target)

/datum/sex_action/npc/npc_facesitting/on_finish(mob/living/user, mob/living/target)
	. = ..()
	user.visible_message(span_warning("[user] gets off [target]'s face."))

/datum/sex_action/npc/npc_facesitting/lock_sex_object(mob/living/carbon/human/user, mob/living/carbon/human/target)
	sex_locks |= new /datum/sex_session_lock(target, BODY_ZONE_PRECISE_MOUTH)
	sex_locks |= new /datum/sex_session_lock(user, ORGAN_SLOT_VAGINA)

///datum/sex_action/npc/npc_facesitting/is_finished(mob/living/user, mob/living/target)
	/*if(user.sexcon.finished_check())
		if(issimple(user))
			var/mob/living/simple_animal/hostile/retaliate/rogue/simpleuser = user
			simpleuser.stoppedfucking(target)
		else
			var/mob/living/carbon/human/humanuser = user
			humanuser.stoppedfucking(target)

		return TRUE
	return FALSE*/
