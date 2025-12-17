/datum/ai_behavior/horny_minotaur_version

/datum/ai_behavior/horny_minotaur_version/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	. = ..()
	to_chat(world, "DEBUG_EXIT: Минотавр [src] активирует файл [__FILE__].")

	var/mob/living/simple_animal/hostile/retaliate/minotaur/boss = controller.pawn
	if(!boss.is_in_horny_mode)
		to_chat(world, "DEBUG_EXIT: Минотавр [src] активирует файл [__FILE__]. Проверка босс не в хорни режиме")
		finish_action(controller, FALSE, target_key)
		return

	var/atom/target = controller.blackboard[target_key]

	if(QDELETED(target) || !(target in view(boss.vision_range, boss)))
		to_chat(world, "DEBUG_EXIT: Минотавр [src] активирует файл [__FILE__]. Проверка потери цели и выход из хорни мода.")
		boss.exit_horny_mode()
		finish_action(controller, FALSE, target_key)
		return

	var/distance = get_dist(boss, target)

	if(distance>1)
		to_chat(world, "DEBUG_EXIT: Минотавр [src] активирует файл [__FILE__].Проверка на дистанцию")
		set_movement_target(controller, target_key)
	else
		if(ishuman(target))
			to_chat(world, "DEBUG_EXIT: Минотавр [src] активирует файл [__FILE__]. Проверка на то что это человека, цель. Начинаем ЕРП!!!")
			var/mob/living/carbon/human/H = target
			H.Knockdown(2 SECONDS)
			//H.adjustBruteLoss(1)закомитил от греха подальше
			boss.visible_message(
				span_danger("[boss] grabbed [H]!"),
				span_userdanger("The [boss] grabbed me!")
				)
