#Использовать logos

Перем Имя Экспорт; // Строка, наименование текущего поля
Перем Тип Экспорт; // ОписаниеТипов
Перем ТипЭлемента Экспорт; // ОписаниеТипов
Перем ЭтоМассив Экспорт; // Булево
Перем ЭтоОбъект Экспорт; // Булево
Перем Синонимы Экспорт; // Массив, элементы строка
Перем РодительКонструктор; // Объект
Перем ОбъектКонструктор; // Объект

Перем Значение Экспорт; // Текущее значение поля

Процедура ПриСозданииОбъекта(РодительПоля,
							ИмяПоля,
							ТипПоля,
							ТипЭлементаПоля = Неопределено,
							ОбъектПоля= Неопределено)

	Синонимы = СтрРазделить(ИмяПоля, " ", Ложь);
	Имя = Синонимы[0];
	Тип = ТипПоля;

	РодительКонструктор = РодительПоля;
	
	Если ТипЭлементаПоля = Неопределено Тогда
		Если ТипПоля = Тип("Массив") Тогда
			ТипЭлементаПоля = Тип("Строка");
		Иначе
			ТипЭлементаПоля = ТипПоля;
		КонецЕсли;
	КонецЕсли;

	ТипЭлемента = ТипЭлементаПоля;
	ЭтоМассив = Тип("Массив") = ТипПоля;
	ОбъектКонструктор = ОбъектПоля;
	ЭтоОбъект = Тип("КонструкторПараметров") = ТипЗнч(ОбъектПоля);

КонецПроцедуры

// Выполняет преобразование объекта конструктора из соответствия
//
// Параметры:
//   ВходящиеСоответствие - Соответствие - входящее соответствие
//
//  Возвращаемое значение:
//   Произвольный - <описание возвращаемого значения>
//
Функция ИзСоответствия(Знач ВходящиеСоответствие) Экспорт

	Если ОбъектКонструктор.Использован() Тогда
		НовыйКонструктор = ОбъектКонструктор.Скопировать();
		Возврат НовыйКонструктор.ИзСоответствия(ВходящиеСоответствие);
	КонецЕсли;

	Возврат ОбъектКонструктор.ИзСоответствия(ВходящиеСоответствие);
КонецФункции

#Область Работа_с_свойствами_класса

// Добавляет для поля дополнительный синоним 
//
// Параметры:
//   НовыйСиноним - Строка - дополнительный синоним поля
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция Синоним(Знач НовыйСиноним) Экспорт

	Синонимы.Добавить(НовыйСиноним);

	РодительКонструктор.ДобавитьСинонимыПоляВИндекс(ЭтотОбъект);

	Возврат ЭтотОбъект;

КонецФункции

// Делает поле массивом
//
// Параметры:
//   ТипЭлементаМассива - ОписаниеТипов - тип элементов массива
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция Массив(Знач ТипЭлементаМассива) Экспорт

	ЭтоМассив = Истина;
	Тип = Тип("Массив");
	ТипЭлемента = ТипЭлементаМассива;

	Возврат ЭтотОбъект;

КонецФункции

// Производит установку значения поля по умолчанию
//
// Параметры:
//   НовоеЗначение - Число, Строка, Дата, Массив, Объект - Значение поля по умолчанию
//
Процедура УстановитьЗначение(НовоеЗначение) Экспорт
	Значение = НовоеЗначение;
КонецПроцедуры

// Возвращает родителя (владельца) конструктора поля
//
//  Возвращаемое значение:
//   Объект.КонструкторПараметров - ссылка на элемент класса <КонструкторПараметров>
//
Функция Конструктор() Экспорт

	Возврат РодительКонструктор;
	
КонецФункции

// Получает описание поля для создания нового поля по основании
//
//  Возвращаемое значение:
//   Структура - описание поля с ключами:
//     * Имя - Строка - Наименование поля (несколько указываются через пробел)
//     * Тип - Тип - Тип значения поля
//     * ТипЭлемента - Тип - Тип элемента поля для массива 
//     * Родитель - Объект.КонструкторПараметров - ссылка на элемент класса <КонструкторПараметров>
//     * ОбъектЭлемента - Объект.КонструкторПараметров - ссылка на элемент класса <КонструкторПараметров>
//     * ЗначениеПоУмолчанию - Произвольный - произвольное значение по умолчанию
//
Функция ОписаниеПоля() Экспорт
	
	СтруктураВозврата = Новый Структура();
	СтруктураВозврата.Вставить("Имя", СтрСоединить(Синонимы, " "));
	СтруктураВозврата.Вставить("Тип", Тип);
	СтруктураВозврата.Вставить("ТипЭлемента", ТипЭлемента);
	СтруктураВозврата.Вставить("Родитель", РодительКонструктор);
	СтруктураВозврата.Вставить("ОбъектЭлемента", ОбъектКонструктор);
	СтруктураВозврата.Вставить("ЗначениеПоУмолчанию", Значение);
	
	Возврат СтруктураВозврата;

КонецФункции

#КонецОбласти

#Область Работа_с_текучими_функциями

// Создает и возвращает новое поле-объект конструктора параметров
//
// Параметры:
//   ИмяПоля             - Строка - имя поля, возможно передача нескольких через пробел.
//   ОбъектПоля          - Объект.КонструкторПараметров - ссылка на объект поле
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеОбъект(Знач ИмяПоля, Знач ОбъектПоля) Экспорт

	Возврат РодительКонструктор.ПолеОбъект(ИмяПоля, ОбъектПоля);

КонецФункции

// Создает и возвращает новое поле-строка конструктора параметров
//
// Параметры:
//   ИмяПоля     - Строка - имя поля, возможно передача нескольких через пробел.
//   ТипЭлемента - строка - значение поля по умолчанию
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеМассив(Знач ИмяПоля, Знач ТипЭлемента) Экспорт

	Возврат РодительКонструктор.ПолеМассив(ИмяПоля, ТипЭлемента);

КонецФункции

// Создает и возвращает новое поле-строка конструктора параметров
//
// Параметры:
//   ИмяПоля             - Строка - имя поля, возможно передача нескольких через пробел.
//   ЗначениеПоУмолчанию - строка - значение поля по умолчанию
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеСтрока(Знач ИмяПоля, ЗначениеПоУмолчанию = "") Экспорт

	Возврат РодительКонструктор.ПолеСтрока(ИмяПоля, ЗначениеПоУмолчанию);

КонецФункции

// Создает и возвращает новое поле-число конструктора параметров
//
// Параметры:
//   ИмяПоля             - Строка - имя поля, возможно передача нескольких через пробел.
//   ЗначениеПоУмолчанию - Число - значение поля по умолчанию
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеЧисло(Знач ИмяПоля, ЗначениеПоУмолчанию = 0) Экспорт

	Возврат РодительКонструктор.ПолеЧисло(ИмяПоля, ЗначениеПоУмолчанию);

КонецФункции

// Создает и возвращает новое поле-дата конструктора параметров
//
// Параметры:
//   ИмяПоля             - Строка - имя поля, возможно передача нескольких через пробел.
//   ЗначениеПоУмолчанию - Дата - значение поля по умолчанию
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеДата(Знач ИмяПоля, ЗначениеПоУмолчанию = Неопределено) Экспорт

	Возврат РодительКонструктор.ПолеДата(ИмяПоля, ЗначениеПоУмолчанию);

КонецФункции

// Создает и возвращает новое поле-булево конструктора параметров
//
// Параметры:
//   ИмяПоля             - Строка - имя поля, возможно передача нескольких через пробел.
//   ЗначениеПоУмолчанию - Булево - значение поля по умолчанию
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеБулево(Знач ИмяПоля, ЗначениеПоУмолчанию = Ложь) Экспорт

	Возврат РодительКонструктор.ПолеБулево(ИмяПоля, ЗначениеПоУмолчанию);

КонецФункции

// Удаляет поле из конструктора параметров
//
// Параметры:
//   ИмяПоля - Строка - имя поля, возможно передача синонима поля.
//
//  Возвращаемое значение:
//   Объект.КонструкторПараметров - ссылка на текущий элемент класса <КонструкторПараметров>
//
Функция УдалитьПоле(Знач ИмяПоля) Экспорт

	Возврат РодительКонструктор.УдалитьПоле(ИмяПоля);

КонецФункции

// Устанавливает признак содержания произвольных полей конструктора параметров
//
//  Возвращаемое значение:
//   Объект.КонструкторПараметров - ссылка на текущий элемент класса <КонструкторПараметров>
//
Функция ПроизвольныеПоля() Экспорт
	Возврат РодительКонструктор.ПроизвольныеПоля();
КонецФункции

#КонецОбласти