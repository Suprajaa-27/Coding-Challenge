import json
import boto3

def is_valid_json(data):
    try:
        json.loads(data)
        return True
    except ValueError:
        return False

def calculate_total_value(data):
    total_value = 0
    for product in data['products']:
        try:
            price = float(product['price'])
            quantity = int(product['quantity'])
            product_total = price * quantity
            total_value += product_total
        except (ValueError, KeyError):
            return None  # Invalid data, return None to indicate an error
    return total_value

def lambda_handler(event, context):
    # S3 bucket and object details
    bucket_name = 's3-bucket-to-trigger-lambda-function'
    object_key = 'product.json'  # Replace with the correct object key

    # Initialize S3 client
    s3 = boto3.client('s3')

    try:
        # Retrieve the uploaded JSON file
        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        json_data = response['Body'].read().decode('utf-8')

        # Check if the content is valid JSON
        if is_valid_json(json_data):
            # Parse the JSON data
            parsed_data = json.loads(json_data)
            
            # Calculate the total value
            total_value = calculate_total_value(parsed_data)
            
            if total_value is not None:
                return {
                    'statusCode': 200,
                    'body': json.dumps({'total_value': total_value})
                }
            else:
                return {
                    'statusCode': 400,
                    'body': json.dumps('Invalid data format in the uploaded JSON file')
                }
        else:
            # Invalid JSON content
            return {
                'statusCode': 400,
                'body': json.dumps('Invalid JSON content in the uploaded file')
            }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error: {str(e)}')
        }
