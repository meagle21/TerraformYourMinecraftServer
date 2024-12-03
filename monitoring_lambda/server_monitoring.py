import boto3
import os

def server_monitoring(event, context):
    log_group_name = 'your-cloudwatch-log-group'
    log_stream_name = 'your-log-stream-name'
    client = boto3.client('logs')

    response = client.get_log_events(
        logGroupName = os.environ[""],
        logStreamName = os.environ[""],
        limit=10
    )

    for event in response['events']:
        print(event['message'])
    return {
        'statusCode': 200,
        'body': "Success"
    }