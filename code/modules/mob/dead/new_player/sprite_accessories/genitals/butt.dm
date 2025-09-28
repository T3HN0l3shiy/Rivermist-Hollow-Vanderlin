
/datum/sprite_accessory/genitals/butt
	icon = 'modular_rmh/icons/mob/sprite_accessory/genitals/butt.dmi'
	color_key_name = "Butt"
	relevant_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/genitals/butt/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(!isdwarf(owner) && !iskobold(owner))
		generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_BELT)//, OFFSET_BELT_F)
	else
		generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_BUTT)//, OFFSET_BUTT)

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
