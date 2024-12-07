import boto3
import json
import os

# Initialize the EC2 client
ec2_client = boto3.client('ec2')

def lambda_handler(event, context):
    # Check for active session in VPC Flow Logs or CloudWatch logs
    active_session = check_for_active_session(event)  # This function is to be defined
    
    # If an active session is detected, start the EC2 instance
    if active_session:
        instance_id = os.environ["INSTANCE_ID"]  # Your EC2 instance ID
        start_ec2_instance(instance_id)
        
    return {
        'statusCode': 200,
        'body': json.dumps('EC2 started due to active session.' if active_session else 'No active session detected.')
    }

def check_for_active_session(event):
    # Check the event for active network activity or session indicators
    # For simplicity, let's assume the function checks for SSH or RDP traffic in the event
    for record in event['Records']:
        if 'ssh' in record['message'].lower() or 'rdp' in record['message'].lower():
            return True
    return False

def start_ec2_instance(instance_id):
    """Starts the EC2 instance if an active session is detected"""
    try:
        ec2_client.start_instances(InstanceIds=[instance_id])
        print(f"Started EC2 instance {instance_id}")
    except Exception as e:
        print(f"Error starting EC2 instance: {e}")
