SELECT res FROM (
WITH 
sch_name AS (SELECT 'diag' AS sn), -- Указать название вашей схемы
sch_name_l AS (SELECT LENGTH(sn) + 1 AS l FROM sch_name),

t AS (
SELECT 
    c.table_name,
    c.column_name,
    c.udt_name,
    CASE 
    	WHEN description LIKE (SELECT '%'||sn||'.%' FROM sch_name)
			THEN SUBSTRING(description, POSITION((SELECT sn||'.' FROM sch_name) IN description) + (SELECT l FROM sch_name_l))
		ELSE '0'
	END AS subst
FROM information_schema.columns c
LEFT JOIN pg_catalog.pg_description d ON d.objsubid = c.ordinal_position 
									AND d.objoid = c.table_name::regclass 
WHERE c.table_schema = (SELECT sn FROM sch_name)
-- AND c.table_name LIKE 'person%' -- При необходимости можно отфильтровать по названиям таблиц
ORDER BY c.table_schema, c.table_name, c.ordinal_position),

ins AS (
SELECT table_name, STRING_AGG(column_name || ' ' || udt_name, ' ') AS insd
FROM t
GROUP BY table_name)

SELECT * 
FROM (VALUES ('erDiagram', 1, 'a')) er (res, rn, tn)

UNION 
SELECT ' ' || table_name || ' { ' || insd || ' }' AS res, 2 AS rn, table_name
FROM ins

UNION
SELECT *
FROM (VALUES (' ', 3, 'a')) sp (res, rn, tn)

UNION
SELECT ' ' || table_name || ' }o--|| ' || subst || ' : ""' AS res, 4 AS rn, table_name
FROM t
WHERE subst <> '0'
) tt
ORDER BY rn, tn