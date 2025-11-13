//predominantly positive traits
//this file is named weirdly so that positive traits are listed above negative ones

/datum/quirk/alcohol_tolerance
	name = "Alcohol Tolerance"
	desc = "Alcohol doesn't affect me much."
	value = 1
	mob_trait = TRAIT_ALCOHOL_TOLERANCE
	gain_text = span_notice("I feel like you could drink a whole keg!")
	lose_text = span_danger("I don't feel as resistant to alcohol anymore. Somehow.")
	medical_record_text = "Patient demonstrates a high tolerance for alcohol."
/*
/datum/quirk/drunkhealing
	name = "Drunken Resilience"
	desc = "Alcohol helps me fight my injuries."
	value = 2
	mob_trait = TRAIT_DRUNK_HEALING
	gain_text = span_notice("I feel like a drink would do you good.")
	lose_text = span_danger("I no longer feel like drinking would ease your pain.")
	medical_record_text = "Patient has unusually efficient liver metabolism and can slowly regenerate wounds by drinking alcoholic beverages."

/datum/quirk/drunkhealing/on_process()
	var/mob/living/carbon/C = quirk_holder
	switch(C.drunkenness)
		if (6 to 40)
			C.adjustBruteLoss(-0.1, FALSE)
			C.adjustFireLoss(-0.05, FALSE)
		if (41 to 60)
			C.adjustBruteLoss(-0.4, FALSE)
			C.adjustFireLoss(-0.2, FALSE)
		if (61 to INFINITY)
			C.adjustBruteLoss(-0.8, FALSE)
			C.adjustFireLoss(-0.4, FALSE)*/

/datum/quirk/empath
	name = "Empath"
	desc = "I can better tell the mood of those around me."
	value = 4
	mob_trait = TRAIT_EMPATH
	gain_text = span_notice("I feel in tune with those around you.")
	lose_text = span_danger("I feel isolated from others.")
	medical_record_text = "Patient is highly perceptive of and sensitive to social cues, or may possibly have ESP. Further testing needed."

/datum/quirk/light_step
	name = "Light Step"
	desc = "Years of skulking about have left my steps quiet, and my hunched gait quicker."
	value = 4
	mob_trait = TRAIT_LIGHT_STEP
	gain_text = span_notice("I walk with a little more litheness.")
	lose_text = span_danger("I start tromping around like a barbarian.")
	medical_record_text = "Patient's dexterity belies a strong capacity for stealth."

/datum/quirk/light_step/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 3, TRUE)

/datum/quirk/musician
	name = "Musician"
	desc = "I am good at playing music. I've also hidden a lute!"
	value = 1
	mob_trait = TRAIT_MUSICIAN
	gain_text = span_notice("I know everything about musical instruments.")
	lose_text = span_danger("I forget how musical instruments work.")
	medical_record_text = "Patient brain scans show a highly-developed auditory pathway."

/datum/quirk/musician/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.adjust_skillrank_up_to(/datum/skill/misc/music, 3, TRUE)
	H.mind.special_items["Lute"] = /obj/item/instrument/lute

/datum/quirk/night_vision
	name = "Low Light Vision"
	desc = "I see a little better in the dark."
	value = 8
	gain_text = span_notice("The shadows seem a little less dark.")
	lose_text = span_danger("Everything seems a little darker.")
	medical_record_text = "Patient's eyes show above-average acclimation to darkness."

/datum/quirk/night_vision/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/organ/eyes/eyes = H.getorgan(/obj/item/organ/eyes)
	if(!eyes || eyes.lighting_alpha)
		return
	eyes.see_in_dark = 7 // Same as half-darksight eyes
	eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	eyes.Insert(H)

/datum/quirk/selfaware
	name = "Self-Aware"
	desc = "I know the extent of my wounds to a terrifying scale."
	value = 2
	mob_trait = TRAIT_SELF_AWARE
	medical_record_text = "Patient demonstrates an uncanny knack for self-diagnosis."

/datum/quirk/spiritual
	name = "Spiritual"
	desc = "I have extraordinary faith in the gods."
	value = 1
	mob_trait = TRAIT_SPIRITUAL
	gain_text = span_notice("I have faith in a higher power.")
	lose_text = span_danger("I lose faith!")
	medical_record_text = "Patient reports a belief in a higher power."

///datum/quirk/spiritual/on_spawn()
//	var/mob/living/carbon/human/H = quirk_holder
//	H.equip_to_slot_or_del(new /obj/item/storage/fancy/candle_box(H), SLOT_IN_BACKPACK)
//	H.equip_to_slot_or_del(new /obj/item/storage/box/matches(H), SLOT_IN_BACKPACK)
