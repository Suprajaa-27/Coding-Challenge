import json
import boto3
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Initialize S3 client
s3_client = boto3.client('s3')

def lambda_handler(event, context):
    try:
        # Extract the bucket name and object key from the S3 event
        bucket_name = event['Records'][0]['s3']['bucket']['name']
        object_key = event['Records'][0]['s3']['object']['key']

        # Download the JSON file from S3
        response = s3_client.get_object(Bucket=bucket_name, Key=object_key)
        json_content = response['Body'].read().decode('utf-8')

        # Parse the JSON content
        json_data = json.loads(json_content)

        # Process the JSON data (e.g., calculate the sum of numbers)
        result = sum(json_data.get('numbers', []))

        # Log the result to CloudWatch
        logger.info(f'Sum of numbers: {result}')

        return {
            'statusCode': 200,
            'body': json.dumps({'message': f'Sum of numbers: {result}'})
        }
    except Exception as e:
        error_message = str(e)
        logger.error(f'Error: {error_message}')
        
        # Capture the specific error status and response
        status_code = 500
        response_body = {'error': 'Internal Server Error', 'details': error_message}
        
        return {
            'statusCode': status_code,
            'body': json.dumps(response_body)
        }
