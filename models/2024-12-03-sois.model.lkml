connection: "lookerdata"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: 2023_12_03_sois_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: 2023_12_03_sois_default_datagroup
