
view: dashboard_data_unnested {
  derived_table: {
    sql: select *
      from `field-dependency-tracker.api_responses.dashboard_data`,UNNEST(fields) as dash_fields ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: dashboard_id {
    type: string
    sql: ${TABLE}.dashboard_id ;;
  }

  dimension: dashboard_name {
    type: string
    sql: ${TABLE}.dashboard_name ;;
    link: {
      label: "View Dashboard"
      url: "https://hack.looker.com/dashboards/{{ dashboard_data_unnested.dashboard_id }}"
    }
  }

  dimension: element_id {
    label: "Tile ID"
    type: string
    sql: ${TABLE}.element_id ;;
  }

  dimension: element_title {
    label: "Tile"
    type: string
    sql: ${TABLE}.element_title ;;
  }

  dimension: explore_name {
    type: string
    sql: ${TABLE}.explore_name ;;
  }

  dimension: fields {
    hidden: yes
    description: "This is the array of fields."
    type: string
    sql: ${TABLE}.fields ;;
  }

  dimension: dash_fields {
    label: "Field"
    type: string
    sql: ${TABLE}.dash_fields ;;
  }

  set: detail {
    fields: [
        dashboard_id,
  dashboard_name,
  element_id,
  element_title,
  explore_name,
  fields,
  dash_fields
    ]
  }
}
