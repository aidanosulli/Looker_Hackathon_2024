# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: look_data {
  hidden: no
    join: look_data__fields {
      view_label: "Look Data: Fields"
      sql: LEFT JOIN UNNEST(${look_data.fields}) as look_data__fields ;;
      relationship: one_to_many
    }
}
view: look_data {
  sql_table_name: `field-dependency-tracker.api_responses.look_data` ;;

  dimension: fields {
    hidden: yes
    sql: ${TABLE}.fields ;;
  }
  dimension: look_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.look_id ;;
  }
  dimension: look_name {
    type: string
    sql: ${TABLE}.look_name ;;
  }
  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }
  dimension: view {
    type: string
    sql: ${TABLE}.view ;;
  }
  measure: count {
    type: count
    drill_fields: [look_name]
  }
}

view: look_data__fields {

  dimension: look_data__fields {
    type: string
    sql: look_data__fields ;;
  }
}