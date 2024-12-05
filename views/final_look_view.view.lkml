
view: final_look_view {
  derived_table: {
    sql: select *
      from field-dependency-tracker.api_responses.look_data, UNNEST(fields) as look_data__fields ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: look_id {
    type: number
    sql: ${TABLE}.look_id ;;
  }

  dimension: look_name {
    type: string
    sql: ${TABLE}.look_name ;;
    link: {
      label: "View Look"
      url: "https://hack.looker.com/looks/{{final_look_view.look_id}}"}
  }

  dimension: sankey_look_name {
    description: "Version appending item type for visualization in sankey diagram."
    type: string
    sql: CONCAT("Look: ",${look_name}) ;;
  }

  dimension: fields {
    hidden: yes
    description: "This is the array of fields."
    type: string
    sql: ${TABLE}.fields ;;
  }

  dimension: view {
    type: string
    sql: ${TABLE}.view ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }

  dimension: look_data__fields {
    label: "Field"
    type: string
    sql: ${TABLE}.look_data__fields ;;
  }

  set: detail {
    fields: [
        look_id,
  look_name,
  fields,
  view,
  model,
  look_data__fields
    ]
  }
}
