В файле **diag_gen_script.sql** находится скрипт для генерации ER-диаграммы по комментариям в колонках таблиц для PostgreSQL. Генерация текста для диаграммы производится в синтаксисе mermaid.js Скрипт рассчитан на случаи, когда в схеме не используются ограничения FK, но нужно показать зависимости между таблицами.

В файле **schema_def.sql** представлен пример вымышленной схемы, на основе которой сгенерирован текст для диаграммы.

В файле **original_diag.md** представлен исходный сгенерированный текст. В файле **edited_diag.md** представлен вариант, вручную скорректированный по бизнес-логике вымышленной схемы.