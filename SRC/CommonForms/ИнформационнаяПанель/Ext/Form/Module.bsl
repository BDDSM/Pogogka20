﻿#Область Переменные_модуля

&НаКлиенте
Перем м_чИнтервалОбновления;
&НаКлиенте
Перем м_бАльтернативныйСпособОбновления;

#КонецОбласти

#Область Управление_формой
// Постобработчики виджетов.
// Вызываются в конце процедуры обновления.

&НаКлиентеНаСервереБезКонтекста
&После("УправлениеФормой")
Процедура ВидБух_УправлениеФормой(Форма)
	
	УправлениеБлоком_ПОЛЬЗ0(Форма);
	
	УправлениеБлоком_ПОЛЬЗ1(Форма);
	
	УправлениеБлоком_ПОЛЬЗ2(Форма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеБлоком_ПОЛЬЗ0(Форма)
	
	Элементы = Форма.Элементы;
	
	Если Элементы.ПОЛЬЗ0.Родитель = Элементы.БлокиПанели Тогда
		// Блок отключен
		Возврат;
	КонецЕсли;
		
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеБлоком_ПОЛЬЗ1(Форма)
	
	Элементы = Форма.Элементы;
	
	Если Элементы.ПОЛЬЗ1.Родитель = Элементы.БлокиПанели Тогда
		// Блок отключен
		Возврат;
	КонецЕсли;
		
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеБлоком_ПОЛЬЗ2(Форма)
	
	Элементы = Форма.Элементы;
	
	Если Элементы.ПОЛЬЗ2.Родитель = Элементы.БлокиПанели Тогда
		// Блок отключен
		Возврат;
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

#Область Команды_формы

// Процедура - Реакция на нажатие кнопки "Обновить"
//
// Параметры:
//  Команда	 - КомандаФормы	 - 
//
&НаКлиенте
Процедура ВидБух_ЗагрузитьКурсыВместо(Команда)
	ОткрытьФорму("Обработка.ЗагрузкаКурсовВалют.Форма.Форма");
КонецПроцедуры

#КонецОбласти

#Область Служебные_методы

// Функция - Пользовательские динамические блоки как строка
// 
// Возвращаемое значение:
//  Строка - пользовательские динамические блоки, видимые на панели
//
&НаКлиенте
Функция ПользовательскиеДинамическиеБлоки()
	Перем Блок, сДинамическиеБлоки;
	
	сДинамическиеБлоки = "";
	
	Для Каждого Блок Из ТаблицаБлоков Цикл
		Если Не Блок.Пометка Тогда
			Продолжить;
		КонецЕсли;
		
		Если НЕ СтрНачинаетсяС(Блок.Имя, "ПОЛЬЗ") Тогда
			Продолжить;
		КонецЕсли; 
		
		Если  НЕ ПустаяСтрока(Блок.ПроцедураОбновленияДанных) Тогда
			сДинамическиеБлоки = сДинамическиеБлоки + ?(ПустаяСтрока(сДинамическиеБлоки), "", ",") + Блок.Имя;
		КонецЕсли;		
	КонецЦикла;
	
	Возврат сДинамическиеБлоки;
КонецФункции

#КонецОбласти

#Область Инициализация_формы

&НаКлиенте
Процедура ВидБух_ПриОткрытииПосле(Отказ)

	Если ТипЗнч(м_чИнтервалОбновления) <> Тип("Число") ИЛИ м_чИнтервалОбновления < 60 Тогда
		м_чИнтервалОбновления = 60;
	КонецЕсли;
	
	Если м_бАльтернативныйСпособОбновления Тогда
		ПодключитьОбработчикОжидания("Подключаемый_Обновление_ПОЛЬЗ", м_чИнтервалОбновления, Ложь);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_Обновление_ПОЛЬЗ()
	Перем бБыстроеОбновление, бПрочитатьДанныеСтатическихБлоков;
	Перем сДинамическиеБлокиИсходные;
	
	бБыстроеОбновление = Ложь;
	бПрочитатьДанныеСтатическихБлоков = Ложь;
	ОбновитьДанныеБлоков(бБыстроеОбновление, бПрочитатьДанныеСтатическихБлоков);
	
КонецПроцедуры

м_чИнтервалОбновления = 7200; // 2 часа
м_бАльтернативныйСпособОбновления = Истина;

#КонецОбласти 