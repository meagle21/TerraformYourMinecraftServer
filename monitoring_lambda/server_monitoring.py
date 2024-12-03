import boto3

def server_monitoring(event, context):
    result = "Hello, World!"
    return {
        'statusCode': 200,
        'body': "Success"
    }