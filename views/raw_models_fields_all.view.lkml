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

  dimension: explore_name {
    type: string
    sql: ${TABLE}.explore_name ;;
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
    primary_key: yes
    type: string
    sql: ${TABLE}.suggest_dimension ;;
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
