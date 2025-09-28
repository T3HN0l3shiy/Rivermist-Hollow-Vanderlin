/datum/customizer/bodypart_feature/underwear
	name = "Underwear"
	customizer_choices = list(/datum/customizer_choice/bodypart_feature/underwear)
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/bodypart_feature/underwear
	name = "Underwear"
	feature_type = /datum/bodypart_feature/underwear
	default_accessory = /datum/sprite_accessory/underwear/athletic_leotard
	sprite_accessories = list(
		/datum/sprite_accessory/underwear/briefs,
		/datum/sprite_accessory/underwear/panties,
		/datum/sprite_accessory/underwear/bikini,
		/datum/sprite_accessory/underwear/leotard,
		/datum/sprite_accessory/underwear/athletic_leotard,
		/datum/sprite_accessory/underwear/braies
		)

/datum/customizer/bodypart_feature/legwear
	name = "Legwear"
	customizer_choices = list(/datum/customizer_choice/bodypart_feature/legwear)
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/bodypart_feature/legwear
	name = "Legwear"
	feature_type = /datum/bodypart_feature/legwear
	//default_accessory = /datum/sprite_accessory/legwear/stockings
	sprite_accessories = list(
		/datum/sprite_accessory/legwear/stockings,
		/datum/sprite_accessory/legwear/stockings/silk,
		/datum/sprite_accessory/legwear/stockings/fishnet,
		)
