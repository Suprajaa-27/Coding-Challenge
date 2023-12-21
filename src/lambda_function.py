import json
import boto3


def lambda_handler(event, context):
    try:
        # Extract bucket name and object key from the S3 event
        bucket_name = event["Records"][0]["s3"]["bucket"]["name"]
        file_name = event["Records"][0]["s3"]["object"]["key"]

        s3 = boto3.client("s3")

        response = s3.get_object(Bucket=bucket_name, Key=file_name)
        content = response["Body"].read().decode("utf-8")
        employees_data = json.loads(content)

        department_totals = {}

        for employee in employees_data:
            department = employee.get("department")
            salary = employee.get("salary")

            if (
                salary is None
                or not isinstance(salary, (int, float))
                or department is None
                or not isinstance(department,(str))
            ):
                raise ValueError("Invalid/missing data for department or salary..")

            if department not in department_totals:
                department_totals[department] = salary
            else:
                department_totals[department] += salary

        # Sort the department totals by total salary
        sorted_departments = dict(sorted(department_totals.items(), key=lambda x: x[1], reverse=True))

        return {"statusCode": 200, "body": json.dumps(sorted_departments)}

    except ValueError as ve:
        error_message = f"Value error occurred: {str(ve)}"
        print(error_message)
        return {"statusCode": 400, "body": json.dumps({"error": error_message})}

    except Exception as e:
        error_message = f"An unexpected error occurred: {str(e)}"
        print(error_message)
        return {"statusCode": 500, "body": json.dumps({"error": error_message})}
