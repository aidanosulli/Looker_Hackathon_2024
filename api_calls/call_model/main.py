import functions_framework
import looker_sdk
from google.cloud import bigquery
import json

@functions_framework.http
def get_field_values(model_name, explore_name):

    #API Call to pull in metadata about fields in a particular explore
  print(model_name, explore_name)
  try:
    explore = sdk.lookml_model_explore(
        lookml_model_name=model_name,
        explore_name=explore_name,
        add_drills_metadata=True
    )
    my_fields = []
    if explore.fields and explore.fields.dimensions:
      for dimension in explore.fields.dimensions:
        dim_def = {
            "field_type": "Dimension",
              "view_name": dimension.view_label,
              "field_name": dimension.label_short,
              "type": dimension.type,
              "description": dimension.description,
              "sql": dimension.sql,
              'sortable': dimension.sortable,
              'can_filter': dimension.can_filter,
              'suggest_dimension': dimension.suggest_dimension,
              'suggest_explore': dimension.suggest_explore,
          }
        my_fields.append(dim_def)
        if explore.fields and explore.fields.measures:
          for measure in explore.fields.measures:
              mes_def = {
                  "field_type": "Measure",
                  "view_name": measure.view_label,
                  "field_name": measure.label_short,
                  "type": measure.type,
                  "description": measure.description,
                  "sql": measure.sql,
                  'sortable': measure.sortable,
                  'can_filter': measure.can_filter,
                  'suggest_dimension': measure.suggest_dimension,
                  'suggest_explore': measure.suggest_explore,

              }
          my_fields.append(mes_def)
    return my_fields
  except Exception as e:
    print(f"error: {e}")
    pass
  finally:
    print('Keep Going')
  return


def load_lookml_data_to_bq(dataset_ref, table_name):
    """Loads LookML model and explore data into BigQuery."""
    table_ref = dataset_ref.table(table_name)
    try:
      if table_ref:
        client.get_table(table_ref)
        print("Table exists, loading data")

    except:
      print("Table doesn't exist, creating it")

      schema = [
          bigquery.SchemaField("model_name", "STRING"),
          bigquery.SchemaField("explore_name", "STRING"),
          bigquery.SchemaField("field_type", "STRING"),
          bigquery.SchemaField("view_name", "STRING"),
          bigquery.SchemaField("field_name", "STRING"),
          bigquery.SchemaField("type", "STRING"),
          bigquery.SchemaField("description", "STRING"),
          bigquery.SchemaField("sql", "STRING"),
          bigquery.SchemaField("sortable", "BOOLEAN"),
          bigquery.SchemaField("can_filter", "BOOLEAN"),
          bigquery.SchemaField("suggest_dimension", "STRING"),
          bigquery.SchemaField("suggest_explore", "STRING"),
      ]
      table = bigquery.Table(table_ref, schema=schema)
      table = client.create_table(table)



    rows_to_insert = []
    lookml_models = sdk.all_lookml_models()

    for model in lookml_models:
        if model:
          for explore in model.explores:  # Iterate through explores for the model
            if explore:
              field_data = get_field_values(model.name, explore.name) 
              if field_data:
                for field in field_data : # Iterate through each field within the explore
                  row = { # Construct the BigQuery row
                    'model_name': model.name,
                    'explore_name': explore.name,
                    'field_type': field.get('field_type'),
                    'view_name': field.get('view_name'),
                    'field_name': field.get('field_name'),
                    'type': field.get('type'),
                    'description': field.get('description'),
                    'sql': field.get('sql'),

                    'sortable': field.get('sortable'),
                    'can_filter': field.get('can_filter'),
                    'suggest_dimension': field.get('suggest_dimension'),
                    'suggest_explore': field.get('suggest_explore')
                  }
                  rows_to_insert.append(row)
                  #if len(rows_to_insert) > 1000:
                  #  break
    json_rows = rows_to_insert
    print(rows_to_insert)
    errors = client.insert_rows_json(table_ref, json_rows)

    if errors == []:
        print("New rows have been added.")
    else:
        print(f"Encountered errors while inserting rows: {errors}")

client = bigquery.Client()
project_id = 'field-dependency-tracker'
dataset_id = 'api_responses'
dataset_ref = bigquery.Dataset(f"{project_id}.{dataset_id}")
table_name = 'raw_models_explore_fields'

sdk = looker_sdk.init40("looker.ini")

def field_finder(request):

    load_lookml_data_to_bq(dataset_ref, table_name)