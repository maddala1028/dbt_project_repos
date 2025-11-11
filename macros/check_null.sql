{% macro check_null(table_name, col_list) %}
{% set null_condition=[] %}
{% for col in col_list %}
{%do null_condition.append(col ~ ' IS NULL ') %}
{% endfor %}

SELECT *,
CASE
    WHEN {{null_condition  | join(' OR ')}} THEN 'FAIL'
    ELSE 'PASS'
    END AS null_check_status
    FROM {{table_name}}
{% endmacro%}