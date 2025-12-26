
/datum/sex_action/hole_storage/anus_store
	name = "Store items in anus"
	hole_id = ORGAN_SLOT_ANUS

/datum/sex_action/hole_storage/anus_store/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!target.getorganslot(ORGAN_SLOT_ANUS))
		return FALSE
	if(check_sex_lock(target, ORGAN_SLOT_ANUS))
		return FALSE
	if(!user.get_active_held_item())
		return FALSE
	return TRUE

/datum/sex_action/hole_storage/anus_store/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!user.get_active_held_item())
		return FALSE
	return TRUE

/datum/sex_action/hole_storage/anus_store/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	var/obj/item/dildo = user.get_active_held_item()

	self = (user == target)

	if(self)
		to_chat(user, sex_session.spanify_force("I start inserting \the [dildo] in my ass..."))
	else
		user.visible_message(span_warning("[user] starts inserting \the [dildo] in [target]'s ass..."))

	playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)


/datum/sex_action/hole_storage/anus_store/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/pain_amt = 4 //base pain amt to use

	var/datum/sex_session/sex_session = get_sex_session(user, target)

	var/obj/item/dildo = user.get_active_held_item()
	if(!dildo)
		sex_session.stop_current_action()
		return
	var/success = SEND_SIGNAL(user, COMSIG_HOLE_TRY_FIT, dildo, hole_id, user, TRUE, FALSE)
	if(success)
		user.update_inv_hands()
		user.update_a_intents()
		if(self)
			to_chat(user, sex_session.spanify_force("I stuff the [dildo] in my ass..."))
		else
			user.visible_message(sex_session.spanify_force("I stuff the [dildo] in [target]'s ass..."))

	else
		if(self)
			to_chat(user, sex_session.spanify_force("I fail to stuff the [dildo] in my ass."))
		else
			user.visible_message(sex_session.spanify_force("I fail to stuff the [dildo] in [target]'s ass."))
			sex_session.stop_current_action()
			return
	sex_session.perform_sex_action(user, 0.5, pain_amt, !self)
	sex_session.handle_passive_ejaculation()

/datum/sex_action/hole_storage/anus_remove
	name = "Remove items from anus"
	hole_id = ORGAN_SLOT_ANUS

/datum/sex_action/hole_storage/anus_remove/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!target.getorganslot(ORGAN_SLOT_ANUS))
		return FALSE
	if(check_sex_lock(target, ORGAN_SLOT_ANUS))
		return FALSE
	var/list/stored_items = list()
	SEND_SIGNAL(target, COMSIG_HOLE_RETURN_ITEM_LIST_SINGLE, stored_items, hole_id)
	if(!stored_items.len)
		return FALSE
	return TRUE

/datum/sex_action/hole_storage/anus_remove/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(user.get_active_held_item())
		return FALSE
	return TRUE

/datum/sex_action/hole_storage/anus_remove/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	self = (user == target)

	if(self)
		to_chat(user, span_warning("I start removing items from my ass..."))
	else
		user.visible_message(span_warning("[user] starts removing items from [target]'s ass..."))

	playsound(target, list('sound/misc/mat/insert (1).ogg','sound/misc/mat/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)


/datum/sex_action/hole_storage/anus_remove/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/pain_amt = 2 //base pain amt to use

	var/datum/sex_session/sex_session = get_sex_session(user, target)

	var/obj/item/removed_item
	removed_item = SEND_SIGNAL(user, COMSIG_HOLE_REMOVE_RANDOM_ITEM, hole_id, target, TRUE)
	if(!removed_item)
		to_chat(user, sex_session.spanify_force("I couldn't find anything inside..."))
		sex_session.stop_current_action()
		return
	if(user.get_active_held_item())
		user.visible_message(sex_session.spanify_force("The [removed_item] falls down on the floor..."))
		removed_item.doMove(get_turf(user))
	else
		if(self)
			to_chat(user, sex_session.spanify_force("I fish out the [removed_item] from my ass..."))
		else
			user.visible_message(sex_session.spanify_force("I fish out the [removed_item] from [target]'s ass..."))
		removed_item.doMove(get_turf(user))
		user.put_in_active_hand(removed_item)
	sex_session.perform_sex_action(user, 0.5, pain_amt, !self)
	sex_session.handle_passive_ejaculation()

