/datum/ai_behavior/horny
	action_cooldown = 2 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION

	var/seekboredom = 0
	var/wrong_action = FALSE
	var/knockdown_need = TRUE


/datum/ai_behavior/horny/setup(datum/ai_controller/controller, target_key, targetting_datum_key)
	. = ..()
	var/datum/horny_targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]
	if(isnull(targetting_datum))
		CRASH("No target datum was supplied in the blackboard for [controller.pawn]")


	var/atom/target = controller.blackboard[target_key]

	var/mob/living/target_living = target
	var/mob/living/basic_mob = controller.pawn

	if(!basic_mob.getorganslot(ORGAN_SLOT_ANUS)) // a little of a hacky way of checking if we have genitals, since the proc always gives anus
		basic_mob.give_genitals()


	if(!basic_mob.GetComponent(/datum/component/arousal)) // give arousal datum if none
		basic_mob.AddComponent(/datum/component/arousal)

	if(world.time < controller.blackboard[BB_HORNY_SEEK_COOLDOWN]) // if on cooldown - stop
		return FALSE

	if(targetting_datum.can_horny(basic_mob, target_living))
		if(basic_mob.gender == MALE)
			basic_mob.visible_message(span_boldwarning("[basic_mob] has his eyes on [target_living], cock throbbing!"))
		else
			basic_mob.visible_message(span_boldwarning("[basic_mob] has her eyes on [target_living], cunt dripping!"))

	basic_mob.start_sex_session(target_living)
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, (target))

	controller.set_blackboard_key(BB_HORNY_STUN_COOLDOWN, world.time)
	SEND_SIGNAL(controller.pawn, COMSIG_HORNY_TARGET_SET, TRUE)

/datum/ai_behavior/horny/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targetting_datum_key)
	. = ..()

	if(world.time < controller.blackboard[BB_HORNY_SEEK_COOLDOWN]) // if on cooldown - stop
		return FALSE

	var/datum/horny_targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]

	if(!targetting_datum)
		CRASH("No target datum was supplied in the blackboard for [controller.pawn]")

	var/atom/current_target = controller.blackboard[target_key]
	var/mob/living/basic_mob = controller.pawn

	if(!targetting_datum.can_horny(basic_mob, current_target))
		finish_action(controller, FALSE, target_key)
		return

	if(ismob(current_target))
		if(current_target:stat == DEAD)
			finish_action(controller, FALSE, target_key)
			return


	var/mob/living/target_living = current_target

	//check if they got away during chasing
	if(seekboredom > 10) //11 cycles of Perform, thus //44 sec
		seekboredom = 0
		finish_action(controller, FALSE, target_key)
		knockdown_need = TRUE
		return

	if(!basic_mob.Adjacent(target_living))
		seekboredom += 1
		return
	else
		seekboredom = CLAMP(seekboredom - 1, 0, 10)

	var/list/arousal_data = list()
	SEND_SIGNAL(basic_mob, COMSIG_SEX_GET_AROUSAL, arousal_data)
	var/is_spent = arousal_data["is_spent"]
	var/last_orgasm_time = arousal_data["last_ejaculation_time"]

	//do stun here
	if(world.time > controller.blackboard[BB_HORNY_STUN_COOLDOWN])
		if(basic_mob.Adjacent(target_living))
			if(target_living.cmode)
				target_living.SetStun(20)
				target_living.SetKnockdown(40)
			else
				target_living.SetStun(30)
				target_living.SetKnockdown(60)
			if(target_living.body_position != LYING_DOWN)
				target_living.emote("gasp")
			controller.set_blackboard_key(BB_HORNY_STUN_COOLDOWN, world.time + 120 SECONDS)
			basic_mob.visible_message(span_danger("[basic_mob] tackles [target_living] down to the ground, dazing them!"))
			knockdown_need = FALSE
			return
		else
			knockdown_need = TRUE

	//do grab here
	if(ishuman(basic_mob))
		if(!basic_mob.pulling)
			if(!target_living.pulledby)
				basic_mob.start_pulling(target_living)

	//do undress here
	if(ishuman(target_living))
		var/mob/living/carbon/human/human_target = target_living
		if(human_target.wear_pants)
			if(human_target.wear_pants.flags_inv & HIDECROTCH && !human_target.wear_pants.genitalaccess)
				if(!do_after(basic_mob, 1 SECONDS, human_target))
					if(!human_target.cmode) //pants off if not in cmode
						basic_mob.visible_message(span_danger("[basic_mob] manages to rip [human_target]'s [human_target.wear_pants.name] off!"))
						var/obj/item/clothing/thepants = human_target.wear_pants
						human_target.dropItemToGround(thepants)
						thepants.throw_at(pick(orange(2, get_turf(human_target))), 2, 1, basic_mob, TRUE)
					else if(human_target.cmode)
						basic_mob.visible_message(span_danger("[basic_mob] manages to tug [human_target]'s [human_target.wear_pants.name] out of the way!"))
					return

	var/datum/sex_session/session = get_sex_session(basic_mob, target_living)

	//starting the action
	if(session)
		var/action_type = basic_mob.select_horny_ai_act(target_living)
		if(isnull(session.current_action))
			session.try_start_action(action_type)
			if(isnull(session.current_action))
				wrong_action = TRUE
				finish_action(controller, FALSE, target_key)


	//check if we are sated
	if(last_orgasm_time > world.time - 10 SECONDS || is_spent)
		session.stop_current_action()
		finish_action(controller, TRUE, target_key)
		return

	//check if dead - still fuck uncon

	/*if(!basic_mob.CanReach(current_target))
		finish_action(controller, FALSE, target_key)
		return*/


/datum/ai_behavior/horny/finish_action(datum/ai_controller/controller, succeeded, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	var/mob/living/basic_mob = controller.pawn

	seekboredom = 0
	knockdown_need = TRUE
	basic_mob.stop_pulling()
	if(!succeeded)
	//if ran away - be angry
		controller.clear_blackboard_key(target_key)
		controller.set_blackboard_key(BB_HORNY_SEEK_COOLDOWN, world.time + 10 SECONDS)
		basic_mob.emote("scream", forced = TRUE)
		wrong_action = FALSE
		controller.CancelActions()
		return



	//if sated - go off and sleep or smth
	controller.clear_blackboard_key(target_key)
	basic_mob.emote("laugh", forced = TRUE)
	controller.set_blackboard_key(BB_HORNY_SEEK_COOLDOWN, world.time + 20 SECONDS)
	wrong_action = FALSE
	controller.CancelActions()

/mob/living/proc/select_horny_ai_act(mob/living/target)
	var/current_action = /datum/sex_action/rub_body
	var/mob/living/target_mob = target
	if(gender == FEMALE && target_mob.gender == MALE)
		switch(rand(1,2))
			if(1) //anal
				current_action = /datum/sex_action/npc/npc_anal_ride_sex
			if(2) //vaginal
				current_action = /datum/sex_action/npc/npc_vaginal_ride_sex
	if(gender == MALE && target_mob.gender == MALE)
		switch(rand(1,2))
			if(1) //oral
				current_action = /datum/sex_action/npc/npc_throat_sex
			if(2) //anal
				current_action = /datum/sex_action/npc/npc_anal_sex
	if(gender == MALE && target_mob.gender == FEMALE)
		switch(rand(1,3))
			if(1) //oral
				current_action = /datum/sex_action/npc/npc_throat_sex
			if(2) //anal
				current_action = /datum/sex_action/npc/npc_anal_sex
			if(3) //vaginal
				current_action = /datum/sex_action/npc/npc_vaginal_sex
	if(gender == FEMALE && target_mob.gender == FEMALE)
		switch(rand(1,3))
			if(1) //oral
				current_action = /datum/sex_action/npc/npc_facesitting
			if(2) //anal
				current_action = /datum/sex_action/npc/npc_rimming
			if(3) //vaginal
				current_action = /datum/sex_action/npc/npc_cunnilingus
	return current_action
