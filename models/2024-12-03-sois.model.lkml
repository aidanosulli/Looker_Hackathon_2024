connection: "lookerdata"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: 2023_12_03_sois_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

explore: raw_models_fields_all  {
  hidden:  no

join: look_data {
  type: left_outer
  relationship: many_to_many
  sql_on: ${raw_models_fields_all.field_name}=${look_data.fields} ;;
}

}

persist_with: 2023_12_03_sois_default_datagroup
