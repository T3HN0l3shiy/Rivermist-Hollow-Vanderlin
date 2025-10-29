/datum/antagonist/werewolf/on_life(mob/user)
	if(!user) return
	var/mob/living/carbon/human/H = user // the werewolf is still a human subtype
	if(H.stat == DEAD) return
	if(H.advsetup) return
	if(H.mind?.has_antag_datum(/datum/antagonist/zombie)) return
	if(forced_transform) return
	// Werewolf transforms at night AND under the sky
	if(!transformed && !transforming)
		if(GLOB.tod == "night")
			if(isturf(H.loc))
				var/turf/loc = H.loc
				if(loc.can_see_sky())
					to_chat(H, span_userdanger("The moonlight scorns me... It is too late."))
					owner.current.playsound_local(get_turf(owner.current), 'sound/music/wolfintro.ogg', 80, FALSE, pressure_affected = FALSE)
					H.flash_fullscreen("redflash3")
					transforming = world.time // timer

	if(!transformed)
		// Begin transformation
		if(transforming)
			if (world.time >= transforming + 35 SECONDS) // Stage 3
				H.werewolf_transform()
				transforming = FALSE
				transformed = TRUE // Mark as transformed

			else if(world.time >= transforming + 25 SECONDS) // Stage 2
				H.flash_fullscreen("redflash3")
				H.emote("agony", forced = TRUE)
				if(COOLDOWN_FINISHED(src, message_cooldown))
					to_chat(H, span_userdanger("UNIMAGINABLE PAIN!"))
					COOLDOWN_START(src, message_cooldown, 5 SECONDS)
				H.Stun(30)
				H.Knockdown(30)

			else if (world.time >= transforming + 10 SECONDS) // Stage 1
				H.emote("")
				if(COOLDOWN_FINISHED(src, message_cooldown))
					to_chat(H, span_warning("I can feel my muscles aching, it feels HORRIBLE..."))
					COOLDOWN_START(src, message_cooldown, 5 SECONDS)
	else
		// Werewolf reverts to human form during the day
		if(GLOB.tod != "night")
			if(!transforming)
				transforming = world.time // Start untransformation phase

			if (world.time >= transforming + 1 MINUTES) // Untransform
				H.emote("rage", forced = TRUE)
				H.werewolf_untransform()
				transformed = FALSE
				transforming = FALSE // Reset untransforming phase

			else if (world.time >= transforming) // Alert player
				if(COOLDOWN_FINISHED(src, message_cooldown))
					H.flash_fullscreen("redflash1")
					to_chat(H, span_warning("Daylight shines around me... the curse begins to fade."))
					COOLDOWN_START(src, message_cooldown, 10 SECONDS)


/mob/living/carbon/human/proc/werewolf_transform()
	if(!mind)
		log_runtime("NO MIND ON [src.name] WHEN TRANSFORMING")
	Paralyze(1, ignore_canstun = TRUE)
	for(var/obj/item/W in src)
		dropItemToGround(W)
	regenerate_icons()
	icon = null
	var/oldinv = invisibility
	invisibility = INVISIBILITY_MAXIMUM
	cmode = FALSE
	src.fully_heal(FALSE)

	var/ww_path
	if(gender == MALE)
		ww_path = /mob/living/carbon/human/species/werewolf/male
	else
		ww_path = /mob/living/carbon/human/species/werewolf/female

	var/mob/living/carbon/human/species/werewolf/W = new ww_path(loc)
	W.set_patron(src.patron)
	W.gender = gender
	W.regenerate_icons()
	W.stored_mob = src
	W.limb_destroyer = TRUE
	W.ambushable = FALSE
	W.dodgetime = 36

	W.cmode_music = 'sound/music/cmode/antag/combat_werewolf.ogg'
	W.skin_armor = new /obj/item/clothing/armor/skin_armor/werewolf_skin(W)

	W.dna?.species.after_creation(src)
	W.apply_status_effect(/datum/status_effect/shapechange_mob/die_with_form, src, FALSE)
	W.grant_language(/datum/language/beast)
	skills?.known_skills = list()
	skills?.skill_experience = list()
	W.grant_language(/datum/language/beast)

	W.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB)
	W.update_a_intents()

	to_chat(W, span_userdanger("I transform into a horrible beast!"))
	W.emote("rage")

	W.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
	W.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
	W.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)

	W.STASTR = 20
	W.STACON = 20
	W.STAEND = 20

	W.add_spell(/datum/action/cooldown/spell/undirected/howl)
	W.add_spell(/datum/action/cooldown/spell/undirected/claws)

	ADD_TRAIT(src, TRAIT_NOSLEEP, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_STRONGBITE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_ZJUMP, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_NOFALLDAMAGE1, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_BASHDOORS, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_ORGAN_EATER, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_NASTY_EATER, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_DEADNOSE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_IGNOREDAMAGESLOWDOWN, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_IGNORESLOWDOWN, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_HARDDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_PIERCEIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_LONGSTRIDER, TRAIT_GENERIC)

	invisibility = oldinv
	W.verbs |= /mob/living/carbon/human/proc/toggle_werewolf_transform

	if(getorganslot(ORGAN_SLOT_PENIS))
		var/obj/item/organ/genitals/penis/penis = W.getorganslot(ORGAN_SLOT_PENIS)
		penis = new /obj/item/organ/genitals/penis/knotted/big
		penis.Insert(W, TRUE)
	if(getorganslot(ORGAN_SLOT_TESTICLES))
		var/obj/item/organ/genitals/filling_organ/testicles/testicles = W.getorganslot(ORGAN_SLOT_TESTICLES)
		testicles = new /obj/item/organ/genitals/filling_organ/testicles/internal
		testicles.Insert(W, TRUE)
	if(getorganslot(ORGAN_SLOT_BREASTS))
		var/obj/item/organ/genitals/filling_organ/breasts/breasts = W.getorganslot(ORGAN_SLOT_BREASTS)
		breasts = new /obj/item/organ/genitals/filling_organ/breasts
		breasts.Insert(W, TRUE)
	if(getorganslot(ORGAN_SLOT_VAGINA))
		var/obj/item/organ/genitals/filling_organ/vagina/vagina = W.getorganslot(ORGAN_SLOT_VAGINA)
		vagina = new /obj/item/organ/genitals/filling_organ/vagina
		vagina.Insert(W, TRUE)



/mob/living/carbon/human/proc/werewolf_untransform(dead,gibbed)
	if(!stored_mob)
		return
	if(!mind)
		log_runtime("NO MIND ON [src.name] WHEN UNTRANSFORMING")
	Paralyze(1, ignore_canstun = TRUE)
	for(var/obj/item/I in src)
		dropItemToGround(I)
	icon = null
	invisibility = INVISIBILITY_MAXIMUM

	var/mob/living/carbon/human/W = stored_mob
	stored_mob = null
	REMOVE_TRAIT(W, TRAIT_NOSLEEP, TRAIT_GENERIC)
	if(dead)
		W.death(gibbed)

	REMOVE_TRAIT(W, TRAIT_NOMOOD, TRAIT_GENERIC)

	var/datum/status_effect/shapechange_mob/die_with_form/stat = has_status_effect(/datum/status_effect/shapechange_mob/die_with_form)
	stat.restore_caster()

	W.remove_spell(/datum/action/cooldown/spell/undirected/howl)
	W.remove_spell(/datum/action/cooldown/spell/undirected/claws)
	W.regenerate_icons()

	to_chat(W, span_userdanger("I return to my facade."))

	W.Knockdown(30)
	W.Stun(30)

	qdel(src)
