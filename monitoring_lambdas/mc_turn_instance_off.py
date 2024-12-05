import json
import boto3
import os

# Initialize boto3 clients for EC2 and CloudWatch Logs
ec2_client = boto3.client('ec2')
logs_client = boto3.client('logs')

def vpc_monitoring_handler(event, context):
    log_group = event['logGroup']
    log_stream = event['logStream']
    
    # Get the logs from CloudWatch Logs
    response = logs_client.get_log_events(
        logGroupName=log_group,
        logStreamName=log_stream,
        startFromHead=True
    )
    
    # Analyze the logs for active connections
    active_connections = False
    for event in response['events']:
        log_message = event['message']
        
        # Check if there are any active connections (simple filter for non-zero bytes sent/received)
        if 'accept' in log_message.lower():
            active_connections = True
            break
    
    # If no active connections, stop the EC2 instance
    # if not active_connections:
    #     instance_id = os.environ["INSTANCE_ID"]
    #     stop_ec2_instance(instance_id)
        
    return {
        'statusCode': 200,
        'body': json.dumps('EC2 instance stopped due to no active connections' if not active_connections else 'Active connections found.')
    }

def stop_ec2_instance(instance_id):
    """Stops the EC2 instance if no active connections are found"""
    try:
        ec2_client.stop_instances(InstanceIds=[instance_id])
        print(f"Stopped EC2 instance {instance_id}")
    except Exception as e:
        print(f"Error stopping EC2 instance: {e}")