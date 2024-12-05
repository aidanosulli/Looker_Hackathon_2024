
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
  }

  dimension: element_id {
    type: string
    sql: ${TABLE}.element_id ;;
  }

  dimension: element_title {
    type: string
    sql: ${TABLE}.element_title ;;
  }

  dimension: explore_name {
    type: string
    sql: ${TABLE}.explore_name ;;
  }

  dimension: fields {
    type: string
    sql: ${TABLE}.fields ;;
  }

  dimension: dash_fields {
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
