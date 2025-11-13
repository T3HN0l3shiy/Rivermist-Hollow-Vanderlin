
//predominantly negative traits
/datum/quirk/monochromatic
	name = "Monochromacy"
	desc = "I see things all gray."
	value = -2
	medical_record_text = "Patient is afflicted with almost complete color blindness."

/datum/quirk/monochromatic/add()
	quirk_holder.add_client_colour(/datum/client_colour/monochrome)

/datum/quirk/monochromatic/remove()
	if(quirk_holder)
		quirk_holder.remove_client_colour(/datum/client_colour/monochrome)
/*
/datum/quirk/phobia
	name = "Phobia"
	desc = "I am afraid of something."
	value = -2
	medical_record_text = "Patient has an irrational fear of something."

/datum/quirk/phobia/post_add()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(new /datum/brain_trauma/mild/phobia(H.client.prefs.phobia), TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/phobia/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.cure_trauma_type(/datum/brain_trauma/mild/phobia, TRAUMA_RESILIENCE_ABSOLUTE)
*/
/datum/quirk/no_taste
	name = "Ageusia"
	desc = "I can't taste a thing."
	value = -1
	mob_trait = TRAIT_AGEUSIA
	gain_text = span_notice("I can't taste anything!")
	lose_text = span_notice("I can taste again!")
	medical_record_text = "Patient suffers from ageusia and is incapable of tasting food or reagents."

/datum/quirk/vegetarian
	name = "Vegetarian"
	desc = "I can't eat meat."
	value = -1
	gain_text = span_notice("I feel repulsion at the idea of eating meat.")
	lose_text = span_notice("I feel like eating meat isn't that bad.")
	medical_record_text = "Patient reports a vegetarian diet."

/datum/quirk/vegetarian/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food &= ~MEAT
	species.disliked_food |= MEAT

/datum/quirk/vegetarian/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		if(initial(species.liked_food) & MEAT)
			species.liked_food |= MEAT
		if(!(initial(species.disliked_food) & MEAT))
			species.disliked_food &= ~MEAT

/datum/quirk/blooddeficiency
	name = "Blood Deficiency"
	desc = "My blood is not enough for me, I need to keep it in me."
	value = -2
	gain_text = span_danger("I feel my vigor slowly fading away.")
	lose_text = span_notice("I feel vigorous again.")
	medical_record_text = "Patient requires regular treatment for blood loss due to low production of blood."

/datum/quirk/blooddeficiency/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(NOBLOOD in H.dna.species.species_traits) //can't lose blood if my species doesn't have any
		return
	else
		if (H.blood_volume > (BLOOD_VOLUME_NORMAL - 25)) // just barely survivable without treatment
			H.blood_volume -= 0.275

/datum/quirk/frail
	name = "Frail"
	desc = "My bones are like sticks."
	value = -4
	mob_trait = TRAIT_EASYLIMBDISABLE
	gain_text = span_danger("I feel frail.")
	lose_text = span_notice("I feel sturdy again.")
	medical_record_text = "Patient has unusually frail bones, recommend calcium-rich diet."

/datum/quirk/heavy_sleeper
	name = "Heavy Sleeper"
	desc = "I sleep like a rock."
	value = -1
	mob_trait = TRAIT_HEAVY_SLEEPER
	gain_text = span_danger("I feel sleepy.")
	lose_text = span_notice("I feel awake again.")
	medical_record_text = "Patient has abnormal sleep study results and is difficult to wake up."
/*

/datum/quirk/hypersensitive
	name = "Hypersensitive"
	desc = ""
	value = -1
	gain_text = span_danger("I seem to make a big deal out of everything.")
	lose_text = span_notice("I don't seem to make a big deal out of everything anymore.")
	medical_record_text = "Patient demonstrates a high level of emotional volatility."

/datum/quirk/hypersensitive/add()
	var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
	if(mood)
		mood.mood_modifier += 0.5

/datum/quirk/hypersensitive/remove()
	if(quirk_holder)
		var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
		if(mood)
			mood.mood_modifier -= 0.5
*/
/datum/quirk/light_drinker
	name = "Light Drinker"
	desc = ""
	value = -1
	mob_trait = TRAIT_LIGHT_DRINKER
	gain_text = span_notice("Just the thought of drinking alcohol makes my head spin.")
	lose_text = span_danger("You're no longer severely affected by alcohol.")
	medical_record_text = "Patient demonstrates a low tolerance for alcohol. (Wimp)"

/datum/quirk/nearsighted //t. errorage
	name = "Nearsighted"
	desc = ""
	value = -3
	gain_text = span_danger("Things far away from you start looking blurry.")
	lose_text = span_notice("I start seeing faraway things normally again.")
	medical_record_text = "Patient requires prescription glasses in order to counteract nearsightedness."

/datum/quirk/nearsighted/add()
	quirk_holder.become_nearsighted(ROUNDSTART_TRAIT)

/datum/quirk/nearsighted/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/face/spectacles/glasses = new(get_turf(H))
	H.put_in_hands(glasses)
	H.equip_to_slot(glasses, ITEM_SLOT_MASK)
	H.regenerate_icons() //this is to remove the inhand icon, which persists even if it's not in their hands

/datum/quirk/nyctophobia
	name = "Nyctophobia"
	desc = "I fear the dark..."
	value = -1
	medical_record_text = "Patient demonstrates a fear of the dark. (Seriously?)"

/datum/quirk/nyctophobia/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(H.dna.species.id in list("shadow", "nightmare"))
		return //we're tied with the dark, so we don't get scared of it; don't cleanse outright to avoid cheese
	var/turf/T = get_turf(quirk_holder)
	var/lums = T.get_lumcount()
	if(lums <= 0.2)
		if(quirk_holder.m_intent == MOVE_INTENT_RUN)
			to_chat(quirk_holder, span_warning("Easy, easy, I need to take it slow... I am in the dark..."))

/datum/quirk/poor_aim
	name = "Poor Aim"
	desc = ""
	value = -1
	mob_trait = TRAIT_POOR_AIM
	medical_record_text = "Patient possesses a strong tremor in both hands."
/*
// Collar signals
#define COMSIG_CARBON_GAIN_COLLAR "carbon_gain_collar"
#define COMSIG_CARBON_LOSE_COLLAR "carbon_lose_collar"

/datum/quirk/slavebourne
	name = "Slavebourne"
	desc = "You are naturally weak without a master's control. Being collared strengthens you."
	value = -6
	gain_text = span_danger("You feel weak and directionless...")
	lose_text = span_notice("You feel more self-reliant.")
	medical_record_text = "Patient exhibits signs of dependency and weakness without proper guidance."
	var/debuff_active = FALSE
	var/master_dead = FALSE
	var/static/DEBUFF_AMOUNT = 4
	var/examine_text = "They have a vacant, submissive look in their eyes."

/datum/quirk/slavebourne/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(!H)
		return

	// Apply initial debuff
	apply_debuff()

	// Register signals
	RegisterSignal(H, COMSIG_CARBON_GAIN_COLLAR, PROC_REF(on_collared))
	RegisterSignal(H, COMSIG_CARBON_LOSE_COLLAR, PROC_REF(on_uncollared))
	RegisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))

	ADD_TRAIT(quirk_holder, TRAIT_SLAVEBOURNE, QUIRK_TRAIT)
	ADD_TRAIT(quirk_holder, TRAIT_SLAVEBOURNE_EXAMINE, QUIRK_TRAIT)

/datum/quirk/slavebourne/on_spawn()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	if(!H)
		return

	H.mind.special_items["Cursed Collar"] = /obj/item/clothing/neck/roguetown/cursed_collar

/datum/quirk/slavebourne/proc/apply_debuff()
	var/mob/living/carbon/human/H = quirk_holder
	if(!H || debuff_active)
		return

	H.change_stat("strength", -DEBUFF_AMOUNT)
	H.change_stat("perception", -DEBUFF_AMOUNT)
	H.change_stat("speed", -DEBUFF_AMOUNT)
	H.change_stat("endurance", -DEBUFF_AMOUNT)
	H.change_stat("perception", -DEBUFF_AMOUNT)
	H.change_stat("constitution", -DEBUFF_AMOUNT)
	H.change_stat("fortune", -DEBUFF_AMOUNT)
	debuff_active = TRUE

/datum/quirk/slavebourne/proc/remove_debuff()
	var/mob/living/carbon/human/H = quirk_holder
	if(!H || !debuff_active)
		return

	H.change_stat("strength", DEBUFF_AMOUNT)
	H.change_stat("perception", DEBUFF_AMOUNT)
	H.change_stat("speed", DEBUFF_AMOUNT)
	H.change_stat("endurance", DEBUFF_AMOUNT)
	H.change_stat("perception", DEBUFF_AMOUNT)
	H.change_stat("constitution", DEBUFF_AMOUNT)
	H.change_stat("fortune", DEBUFF_AMOUNT)
	debuff_active = FALSE

/datum/quirk/slavebourne/proc/on_collared(mob/living/carbon/human/source, obj/item/clothing/neck/roguetown/cursed_collar/collar)
	SIGNAL_HANDLER
	if(!collar || !collar.collar_master || master_dead)
		return

	remove_debuff()
	RegisterSignal(collar.collar_master, COMSIG_LIVING_DEATH, PROC_REF(on_master_death))
	RegisterSignal(collar.collar_master, COMSIG_LIVING_REVIVE, PROC_REF(on_master_revive))
	to_chat(source, span_notice("Your master's control flows through the collar, strengthening you!"))

/datum/quirk/slavebourne/proc/on_uncollared()
	SIGNAL_HANDLER
	var/mob/living/carbon/human/H = quirk_holder
	if(!H)
		return

	// Unregister master death signals if they exist
	var/obj/item/clothing/neck/roguetown/cursed_collar/collar = H.get_item_by_slot(SLOT_NECK)
	if(collar?.collar_master)
		UnregisterSignal(collar.collar_master, list(
			COMSIG_LIVING_DEATH,
			COMSIG_LIVING_REVIVE
		))

	apply_debuff()
	to_chat(H, span_warning("Without a master, you feel purposeless again..."))

/datum/quirk/slavebourne/proc/on_master_death(mob/living/carbon/human/master)
	SIGNAL_HANDLER
	if(master_dead)
		return

	master_dead = TRUE
	apply_debuff()
	to_chat(quirk_holder, span_userdanger("You feel your master's death tear through your very being! Your abilities are permanently diminished..."))

/datum/quirk/slavebourne/proc/on_master_revive(mob/living/carbon/human/master)
	SIGNAL_HANDLER
	if(!master_dead)
		return

	master_dead = FALSE
	remove_debuff()
	to_chat(quirk_holder, span_notice("You feel your master's life force return! Your abilities are restored!"))

/datum/quirk/slavebourne/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!H)
		return

	// Clean up all signals
	UnregisterSignal(H, list(
		COMSIG_CARBON_GAIN_COLLAR,
		COMSIG_CARBON_LOSE_COLLAR
	))

	// Clean up any master signals if collared
	var/obj/item/clothing/neck/roguetown/cursed_collar/collar = H.get_item_by_slot(SLOT_NECK)
	if(collar?.collar_master)
		UnregisterSignal(collar.collar_master, list(
			COMSIG_LIVING_DEATH,
			COMSIG_LIVING_REVIVE
		))

	remove_debuff()
	UnregisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE)

	REMOVE_TRAIT(quirk_holder, TRAIT_SLAVEBOURNE, QUIRK_TRAIT)
	REMOVE_TRAIT(quirk_holder, TRAIT_SLAVEBOURNE_EXAMINE, QUIRK_TRAIT)

/datum/quirk/slavebourne/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_info("\nThey have a submissive aura about them.")*/

