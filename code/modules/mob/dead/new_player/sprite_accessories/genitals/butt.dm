/datum/sprite_accessory/genitals/butt
	icon = 'modular_rmh/icons/mob/sprite_accessory/genitals/butt.dmi'
	color_key_name = "Butt"
	relevant_layers = list(BODY_BEHIND_LAYER)

/datum/sprite_accessory/genitals/butt/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	gender_genitals_adjust(appearance_list, organ, bodypart, owner, OFFSET_BUTT)

/datum/sprite_accessory/genitals/butt/get_icon_state(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	var/obj/item/organ/genitals/butt/buttie = organ
	return "[icon_state]_[buttie.organ_size]"

/datum/sprite_accessory/genitals/butt/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	//if(organ.visible_through_clothes)
	//	return TRUE
	//var/obj/item/organ/genitals/butt/buttie = organ
	if(owner)
		if(owner.underwear)
			return FALSE
	return is_human_part_visible(owner, HIDEBUTT|HIDEUNDIESBOT)

/datum/sprite_accessory/genitals/butt/pair
	name = "Pair"
	icon_state = "pair"
	color_key_defaults = list(KEY_SKIN_COLOR)
