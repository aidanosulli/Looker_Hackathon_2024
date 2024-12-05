view: raw_models_fields_all {
  derived_table: {
    sql: select *
      from `field-dependency-tracker.api_responses.raw_models_fields_all` ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: model_name {
    type: string
    sql: ${TABLE}.model_name ;;
  }

  dimension: sankey_model_name {
    description: "Version appending item type for visualization in sankey diagram."
    type: string
    sql: CONCAT("Model: ",${model_name}) ;;
  }

  dimension: explore_name {
    type: string
    sql: ${TABLE}.explore_name;;
    link: {
      label: "View Explore"
      url: "https://hack.looker.com/explore/{{model_name_for_url}}/{{explore_name_for_url}}"}
  }

  dimension: sankey_explore_name {
    description: "Version appending item type for visualization in sankey diagram."
    type: string
    sql:CONCAT("Explore: ",${explore_name}) ;;
  }

  dimension: explore_name_for_url {
    hidden: yes
    type: string
    sql: LOWER(REPLACE(${explore_name}, ' ', '_'));;
  }

  dimension: model_name_for_url {
    hidden: yes
    type:  string
    sql: LOWER(REPLACE(${model_name}, ' ', '_'));;
  }

  dimension: field_type {
    type: string
    sql: ${TABLE}.field_type ;;
  }

  dimension: view_name {
    type: string
    sql: ${TABLE}.view_name ;;
  }

  dimension: field_name {
    description: "This is the array of fields."
    hidden:  yes
    type: string
    sql: ${TABLE}.field_name ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: sql {
    type: string
    sql: ${TABLE}.sql ;;
  }

  dimension: sortable {
    type: yesno
    sql: ${TABLE}.sortable ;;
  }

  dimension: can_filter {
    type: yesno
    sql: ${TABLE}.can_filter ;;
  }

  dimension: suggest_dimension {
    label: "Field"
    primary_key: yes
    type: string
    sql: ${TABLE}.suggest_dimension ;;
  }

  dimension: sankey_field_name {
    description: "Version appending item type for visualization in sankey diagram."
    type: string
    sql: CONCAT("Field: ", ${suggest_dimension});;
  }

  dimension: suggest_explore {
    type: string
    sql: ${TABLE}.suggest_explore ;;
  }

  set: detail {
    fields: [
        model_name,
  explore_name,
  field_type,
  view_name,
  field_name,
  type,
  description,
  sql,
  sortable,
  can_filter,
  suggest_dimension,
  suggest_explore
    ]
  }
}
