import functions_framework
import looker_sdk
from google.cloud import bigquery
import json

@functions_framework.http
def field_finder(request):

    # Initialize the Looker SDK
    sdk = looker_sdk.init40("looker.ini") 

    # Get all looks
    looks = sdk.all_looks()

    look_list = []

    # Process the results (example: extract look titles)
    look_titles = [look.title for look in looks]

    # Loop each look, call look(), save data into a list.
    for look in looks:
        look_id = look.id
        look_data = sdk.look(look_id)
        look_list.append({
            "look_id": look_data['id'],
            "look_name": look_data['title'],
            "fields": look_data['query']['fields'], 
            "view": look_data['query']['view'],
            "model" : look_data['query']['model']
        })

    # BigQuery schema for look_list
    bigquery_schema = [
        bigquery.SchemaField("look_id", "INTEGER", mode="REQUIRED"),
        bigquery.SchemaField("look_name", "STRING", mode="REQUIRED"),
        bigquery.SchemaField("fields", "STRING", mode="REPEATED"),  
        bigquery.SchemaField("view", "STRING", mode="NULLABLE"), 
        bigquery.SchemaField("model", "STRING", mode="NULLABLE") 

    ]

    # BigQuery client and table reference
    client = bigquery.Client()
    table_id = "your_project.your_dataset.look_data"  # Replace with your details

    job_config = bigquery.LoadJobConfig(
                schema=bigquery_schema,
                write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE  
            )

    # Run the load job
    load_job = client.load_table_from_json(look_list, table_id, job_config=job_config)
    load_job.result()  # Wait for the job to complete

    return f"Loaded {len(look_list)} rows into {table_id}"