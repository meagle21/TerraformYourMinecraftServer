import boto3
import os

def vpc_monitoring_handler(event, context):
    client = boto3.client('logs')

    response = client.get_log_events(
        logGroupName = os.environ["CLOUDWATCH_LOG_GROUP"],
        logStreamName = os.environ["LOG_STREAM_NAME"],
        limit=10
    )
    return {
        'statusCode': 200,
        'body': response['events']
    }