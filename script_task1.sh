#!/bin/bash

menushow () {
	i=1
	if [ "$1" == "Управление пользователями" ]
	then
		echo
		echo Главное меню:
	fi
	if [ "$1" == "Удалить пользователя" ]
        then
			echo
            echo Меню управления пользователями:
        fi
	if [ "$1" == "Добавить группу" ]
        then
			echo
            echo Меню управления группами:
        fi
	if [ "$1" == "Найти пользователя" ]
        then
			echo
            echo Меню поиска:
        fi
	if [ "$1" == "Добавить пользователя в группу" ]
        then
			echo    
			echo Меню изменения состава группы:
        fi
	for arg in "$@"; do
		echo "$i) $arg"
		((i++))
	done
}
PS3='Ваш выбор: '
options=("Управление пользователями" "Управление группами" "Поиск пользователей или групп" "Справка" "Выход из программы")
optionsuser=("Удалить пользователя" "Блокировка пользователя" "Добавить пользователя" "Добавить пользователя в группу" "Смена пароля пользователя" "Справка" "Выход в главное меню" "Выход из программы")
optionsgroup=("Добавить группу" "Удалить группу" "Изменить состав группы" "Справка" "Выход в главное меню" "Выход из программы")
optionsgroupsostav=("Добавить пользователя в группу" "Удалить пользователя из группы" "Справка" "Выход в предыдущее меню" "Выход в главное меню" "Выход из программы")
optionssearch=("Найти пользователя" "Найти группу" "Справка" "Выход в главное меню" "Выход из программы")

main () {
	if [ "$1" == "--help" ]
	then
        	echo "spravka"
	else

        	if [ $(id -u) != "0" ]
        	then
                	echo "у вас нет прав на исполнение данного файла" >&2
                	exit
        	fi
	echo Авторы: Авдеев, Васильев, Комиссаров, Привалов
	echo Программа управления пользователями и группами
	echo Главное меню:
	select opt in "${options[@]}"
	do
		case $opt in
			"Управление пользователями")
				echo
				echo Меню управления пользователями
				select optuser in "${optionsuser[@]}"
				do
					case $optuser in
						"Удалить пользователя")
							./delete_user.sh
							menushow "${optionsuser[@]}"
							;;
						"Блокировка пользователя")
							./block_user.sh
							menushow "${optionsuser[@]}"
							;;
						"Добавить пользователя")
							./add_user.sh
							menushow "${optionsuser[@]}"
							;;
						"Добавить пользователя в группу")
							./add_user_group.sh
							menushow "${optionsuser[@]}"
							;;
						"Смена пароля пользователя")
							./change_passwd.sh
							menushow "${optionsuser[@]}"
							;;
						"Справка")
							echo "Это меню управления пользователями"
							echo "Здесь вы можете добавлять пользователей"
							echo "Удалять пользователей, добавлять в группу"
							echo "А так же изменять пароль пользователя"
							menushow "${optionsuser[@]}"
							;;
						"Выход в главное меню")
							menushow "${options[@]}"
							break
							;;
						"Выход из программы")
                            return 0
                            ;;
						*) echo неверный выбор >&2;;
					esac
				done
				;;
			"Управление группами")
				echo
				echo Меню управления группами:
				select optgroup in "${optionsgroup[@]}"
				do
					case $optgroup in
						"Добавить группу")
                                                        ./add_group.sh
							menushow "${optionsgroup[@]}"
							;;
						"Удалить группу")
                                                        ./delete_group.sh
							menushow "${optionsgroup[@]}"
							;;
						"Изменить состав группы")
							echo
							echo Меню изменения состава группы:
							select optgroupsostav in "${optionsgroupsostav[@]}"
							do
								case $optgroupsostav in
									"Добавить пользователя в группу")
										./add_user_group.sh
										menushow "${optionsgroupsostav[@]}"
										;;
									"Удалить пользователя из группы")
										./delete_user_group.sh
										menushow "${optionsgroupsostav[@]}"
										;;
									"Справка")
										echo "Это меню изменения состава группы"
										echo "Здесь вы можете добавлять и удалять пользователей из группы"
										menushow "${optionsgroupsostav[@]}" 
										;;
									"Выход в предыдущее меню")
										menushow "${optionsgroup[@]}"
										break
										;;
									"Выход в главное меню")
										menushow "${options[@]}"
										break 2
										;;
									"Выход из программы")
										return 0
										;;
									*) echo неверный выбор >&2;;
								esac
							done
							;;
						"Справка")
							echo "Это меню управления группами"
							echo "Здесь вы можете добавлять и удалять группы, а также менять их состав"
							menushow "${optionsgroup[@]}"
							;;
						"Выход в главное меню")
							menushow "${options[@]}"
							break
							;;
						"Выход из программы")
                            return 0
							;;
						*) echo неверный выбор >&2;;
					esac
				done
				;;
			"Поиск пользователей или групп")
				echo
				echo Меню поиска:
				select optsearch in "${optionssearch[@]}"
				do
					case $optsearch in
						"Найти пользователя")
							./find_user.sh
							menushow "${optionssearch[@]}"
							;;
						"Найти группу")
                                                        ./find_group.sh
							menushow "${optionssearch[@]}"
							;;
						"Справка")
							echo "Это меню поиска пользователей и групп"
							echo "Здесь вы можете найти пользователя или группу"
							menushow "${optionssearch[@]}"
							;;
						"Выход в главное меню")
							menushow "${options[@]}"
							break
							;;
						"Выход из программы")
                            return 0
                            ;;
						*) echo неверный выбор >&2;;
					esac
				done
				;;
			"Справка")
				echo "Это главное меню программы"
				echo "Здесь вы можете управлять пользователями и группами, а так же осуществлять их поиск"
				menushow "${options[@]}"
				;;
			"Выход из программы")
				return 0
				;;
			*) echo неверный выбор >&2;;
		esac
	done
	fi
}

main "$@"
