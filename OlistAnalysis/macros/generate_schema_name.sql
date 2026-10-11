-- Cette macro permet d'utiliser directement le schéma personnalisé
-- défini dans dbt_project.yml, sans le préfixer par le schéma cible
-- par défaut de l'environnement.

{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
