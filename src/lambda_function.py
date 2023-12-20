import json
import boto3

def lambda_handler(event, context):
    bucket_name = 's3-trigger-lambda-function-test12345'
    file_name = 'employees.json'
    
    s3 = boto3.client('s3')
    
    try:
        response = s3.get_object(Bucket=bucket_name, Key=file_name)
        content = response['Body'].read().decode('utf-8')
        employees_data = json.loads(content)
        
        department_totals = {}
        
        for employee in employees_data:
            department = employee.get('department')
            salary = employee.get('salary')
            
            
            if salary is None or not isinstance(salary, (int, float)) or department is None:
                raise ValueError("Invalid/missing data for department or salary..")
            
            if department not in department_totals:
                department_totals[department] = salary
            else:
                department_totals[department] += salary
        
            sorted_departments = sorted(department_totals.items(), key=lambda x: x[1], reverse=True)

        for department, total_salary in sorted_departments:
            print(f"Department: {department}, Total Salary: {total_salary}")
        
        return {
            'statusCode': 200,
            'body': json.dumps(department_totals)
        }
    
    except ValueError as ve:
        error_message = f"Value error occurred: {str(ve)}"
        print(error_message)
        return {
            'statusCode': 400,
            'body': json.dumps({'error': error_message})
        }
    
    except Exception as e:
        error_message = f"An unexpected error occurred: {str(e)}"
        print(error_message)
        return {
            'statusCode': 500,
            'body': json.dumps({'error': error_message})
        }