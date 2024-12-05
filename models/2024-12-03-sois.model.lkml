connection: "lookerdata"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: 2023_12_03_sois_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

explore: raw_models_fields_all  {
  hidden:  no

join: final_look_view {
  type: left_outer
  relationship: many_to_many
  sql_on:  ${raw_models_fields_all.suggest_dimension}=${final_look_view.look_data__fields} ;;
}

join: dashboard_data_unnested {
  type: left_outer
  relationship: many_to_many
  sql_on: ${raw_models_fields_all.suggest_dimension}=${dashboard_data_unnested.dash_fields} ;;
}

}

persist_with: 2023_12_03_sois_default_datagroup

explore: aaron_test {
  label: "Aaron Test"
  from: raw_models_fields_all

  join:  look_data__fields {
    relationship: many_to_many
    sql_on: ${aaron_test.suggest_dimension} = ${look_data__fields.look_data__fields} ;;
  }

  join: look_data {
    sql: LEFT JOIN UNNEST(${look_data.fields}) as look_data__fields ;;
    relationship: one_to_many
  }
}
