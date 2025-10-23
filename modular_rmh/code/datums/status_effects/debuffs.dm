/datum/status_effect/facial
	id = "facial"
	alert_type = null // don't show an alert on screen
	duration = 12 MINUTES // wear off eventually or until character washes themselves

/datum/status_effect/facial/internal
	id = "creampie"
	alert_type = null // don't show an alert on screen
	duration = 7 MINUTES // wear off eventually or until character washes themselves

/datum/status_effect/facial/on_apply()
	RegisterSignal(owner, list(COMSIG_COMPONENT_CLEAN_ACT, COMSIG_COMPONENT_CLEAN_FACE_ACT),PROC_REF(clean_up))
	return ..()

/datum/status_effect/facial/on_remove()
	UnregisterSignal(owner, list(COMSIG_COMPONENT_CLEAN_ACT, COMSIG_COMPONENT_CLEAN_FACE_ACT))
	return ..()

///Callback to remove pearl necklace
/datum/status_effect/facial/proc/clean_up(datum/source, strength)
	if(strength == CLEAN_WASH && !QDELETED(owner))
		if(!owner.has_stress_type(/datum/stress_event/bathcleaned))
			to_chat(owner, span_notice("I feel much cleaner now!"))
			owner.add_stress(/datum/stress_event/bathcleaned)
		owner.remove_status_effect(src)

/datum/status_effect/edged_penis_cooldown
	id = "tired_penis"
	alert_type = null
	duration = 7 MINUTES

/datum/status_effect/blue_bean
	id = "blue_bean"
	alert_type = null
	duration = -1

/datum/status_effect/blue_bean/on_apply()
	. = ..()
	owner.add_stress(/datum/stress_event/blue_bean)

/datum/status_effect/blue_bean/on_remove()
	. = ..()
	owner.remove_stress(/datum/stress_event/blue_bean)

/datum/status_effect/blue_balls
	id = "blue_balls"
	alert_type = null
	duration = -1

/datum/status_effect/blue_balls/on_apply()
	. = ..()
	owner.add_stress(/datum/stress_event/blue_balls)

/datum/status_effect/blue_balls/on_remove()
	. = ..()
	owner.remove_stress(/datum/stress_event/blue_balls)

/datum/status_effect/edging_overstimulation
	id = "edging_overstimulation"
	duration = 5 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/edging_overstimulation
	effectedstats = list("strength" = -1, "speed" = -2, "intelligence" = -2)

/atom/movable/screen/alert/status_effect/edging_overstimulation
	name = "Overstimulated"
	desc = "I have been going at it for too long without release, I need relief..."

/datum/status_effect/debuff/orgasmbroken
	id = "orgasmbroken"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/orgasmbroken
	effectedstats = list("intelligence" = -10, "strength" = -2, "speed" = -2, "perception" = -5, "endurance" = 2, "constitution" = -2)
	duration = -1

/datum/status_effect/debuff/orgasmbroken/on_apply()
	. = ..()
	owner.add_movespeed_modifier("ORGASM_SLOWDOWN", multiplicative_slowdown=4)

/datum/status_effect/debuff/orgasmbroken/on_remove()
	. = ..()
	owner.remove_movespeed_modifier("ORGASM_SLOWDOWN")

/atom/movable/screen/alert/status_effect/debuff/orgasmbroken
	name = "Orgasm Broken"
	desc = "My legs are shaking, but I need more."
	icon_state = "debuff"

/datum/status_effect/debuff/nympho_addiction
	id = "nympho_addiction"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/nympho_addiction
	//effectedstats = list("intelligence" = -20, "strength" = -8, "speed" = -6, "perception" = -5, "endurance" = 2, "constitution" = -2)
	duration = -1

/datum/status_effect/debuff/nympho_addiction/on_apply()
	. = ..()
	var/mob/living/carbon/human/human = owner
	human.charflaw = new /datum/charflaw/addiction/lovefiend(human)

/atom/movable/screen/alert/status_effect/debuff/nympho_addiction
	name = "Addicted to Sex"
	desc = "I want to do it again. And again. And again."
	icon_state = "debuff"

/datum/status_effect/debuff/cumbrained
	id = "cumbrained"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/cumbrained
	effectedstats = list("intelligence" = -10, "strength" = -6, "speed" = -6)
	duration = -1

/atom/movable/screen/alert/status_effect/debuff/cumbrained
	name = "Cum Brained"
	desc = "It's hard to think..."
	icon_state = "debuff"

/datum/status_effect/debuff/cumbrained/tick()
	. = ..()
	if(!owner)
		return

	if(!MOBTIMER_FINISHED(owner, "cumbrained_ticker", rand(30,90)SECONDS))
		return

	MOBTIMER_SET(owner, "cumbrained_ticker")

	var/list/arousal_data = list()
	SEND_SIGNAL(owner, COMSIG_SEX_GET_AROUSAL, arousal_data)

	if(arousal_data["arousal"] < 40)
		SEND_SIGNAL(owner, COMSIG_SEX_ADJUST_AROUSAL, rand(25, 35))//so it instantly fully arouses
	else
		SEND_SIGNAL(owner, COMSIG_SEX_ADJUST_AROUSAL, rand(5, 15))
	to_chat(owner, span_love("My body wants more..."))

/datum/status_effect/debuff/loinspent
	id = "loinspent"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/loinspent
	duration = -1

/atom/movable/screen/alert/status_effect/debuff/loinspent
	name = "Spent Loins"
	desc = "It's starting to hurt a bit..."
	icon_state = "debuff"


/datum/status_effect/debuff/loinspent/tick()
	. = ..()
	if(!owner)
		return

	if(!MOBTIMER_FINISHED(owner, "chafing_loins", rand(20,90)SECONDS))
		return

	MOBTIMER_SET(owner, "chafing_loins")

	var/mob/living/carbon/human/human = owner
	if(human.underwear)
		if(rand(5))
			to_chat(human, span_love("I feel [human.underwear] rub against me..."))
		SEND_SIGNAL(owner, COMSIG_SEX_ADJUST_AROUSAL, rand(10,20))
	else if(human.wear_pants)
		if(human.wear_pants.flags_inv & HIDECROTCH && !human.wear_pants.genitalaccess)
			if(rand(5))
				to_chat(human, span_love("I feel [human.wear_pants] rub against me..."))
			SEND_SIGNAL(owner, COMSIG_SEX_ADJUST_AROUSAL, rand(5,10))


/datum/status_effect/debuff/bloatone
	id = "bloatone"
	duration = 5 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/bloatone
	examine_text = span_notice("Their belly is bulging...")
	effectedstats = list("constitution" = 1, "speed" = -1)

/atom/movable/screen/alert/status_effect/bloatone
	name = "Bloated"
	desc = "Bit full..."
	icon_state = "status"

/datum/status_effect/debuff/bloattwo
	id = "bloattwo"
	duration = 5 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/bloattwo
	examine_text = span_notice("Their belly is bulging largely...")
	effectedstats = list("constitution" = 2, "speed" = -2)

/datum/status_effect/debuff/bloattwo/on_apply()
	. = ..()
	if(owner.has_status_effect(/datum/status_effect/debuff/bloatone))
		owner.remove_status_effect(/datum/status_effect/debuff/bloatone)

/atom/movable/screen/alert/status_effect/bloattwo
	name = "Bloated"
	desc = "So full..."
	icon_state = "status"

/datum/stress_event/loinache
	timer = 1 MINUTES
	stress_change = 2
	desc = span_red("My loins ache!")

/datum/stress_event/loinachegood
	timer = 5 MINUTES
	stress_change = -3
	desc = list(span_green("My loins took a GOOD beating!~"),span_green("My loins got slammed GOOD!"),span_green("My loins got beaten GOOD!"))
