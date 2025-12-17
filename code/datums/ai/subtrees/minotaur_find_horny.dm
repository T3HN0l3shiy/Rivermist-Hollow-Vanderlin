/datum/ai_planning_subtree/minotaur_find_horny
/datum/ai_planning_subtree/minotaur_find_horny/SelectBehaviors(datum/ai_controller/controller, delta_time)
	to_chat(world, "DEBUG_EXIT: Минотавр [src] активирует файл [__FILE__].")
	. = ..()
	var/mob/living/simple_animal/hostile/retaliate/minotaur/boss = controller.pawn

	if(boss.is_in_horny_mode)
		to_chat(world, "Проверка босса в хорни моде. 1 ")
		return SUBTREE_RETURN_FINISH_PLANNING

	var/datum/horny_targetting_datum/horny_datum = controller.blackboard[BB_HORNY_TARGETTING_DATUM]
	if(isnull(horny_datum))
		to_chat(world, "Проверка (isnull(horny_datum)).2 ")
		return

	var/list/horny_targets = list()
	for(var/mob/living/carbon/human/H in view(boss.vision_range, boss))
		to_chat(world, "Активация цикла for 3 ")
		if(horny_datum.can_horny(boss, H))
			to_chat(world, "Добавление хорни таргета 4 ")
			horny_targets += H

	if(!length(horny_targets))
		to_chat(world, "Проверка (!length(horny_targets)).5 ")
		return

	var/mob/living/chosen_target = pick(horny_targets)


	boss.enter_horny_mode(chosen_target)
	to_chat(world, "Вызван  enter_horny_mode")

	if(controller)
		controller.queue_behavior(/datum/ai_behavior/horny_minotaur_version, BB_BASIC_MOB_CURRENT_HORNY_TARGET)
		to_chat(world, "horny_minotaur_version ПОСТАВЛЕН В ОЧЕРЕДЬ!!!")

	to_chat(world, "Выбор цели последующее возвращение.6 ")
	return SUBTREE_RETURN_FINISH_PLANNING
