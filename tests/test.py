import json
import unittest
from unittest.mock import patch, MagicMock
import sys

sys.path.append("../src")


from lambda_function import lambda_handler


class TestLambdaFunction(unittest.TestCase):
    @patch("lambda_function.boto3")
    def test_lambda_handler_valid_data(self, mock_boto3):
        # Define a sample event with valid data
        event = {
            "Records": [
                {
                    "s3": {
                        "bucket": {"name": "test-bucket"},
                        "object": {"key": "test-file.json"},
                    }
                }
            ]
        }

        mock_s3 = MagicMock()
        mock_boto3.client.return_value = mock_s3
        mock_s3.get_object.return_value = {
            "Body": MagicMock(
                read=MagicMock(
                    return_value=json.dumps(
                        [
                            {"department": "HR", "salary": 50000},
                            {"department": "Finance", "salary": 60000},
                            {"department": "HR", "salary": 55000},
                        ]
                    ).encode("utf-8")
                )
            )
        }

        result = lambda_handler(event, None)

        expected_result = {"Finance": 60000, "HR": 105000}

        self.assertEqual(result["statusCode"], 200)
        self.assertEqual(json.loads(result["body"]), expected_result)

    @patch("lambda_function.boto3")
    def test_lambda_handler_salary_not_numeric_or_none(self, mock_boto3):
        # Define a sample event with missing or invalid salary values
        event = {
            "Records": [
                {
                    "s3": {
                        "bucket": {"name": "test-bucket"},
                        "object": {"key": "test-file.json"},
                    }
                }
            ]
        }

        mock_s3 = MagicMock()
        mock_boto3.client.return_value = mock_s3
        mock_s3.get_object.return_value = {
            "Body": MagicMock(
                read=MagicMock(
                    return_value=json.dumps(
                        [
                            {"department": "HR", "salary": "invalid"},
                            {"department": "Finance", "salary": None},
                            {"department": "HR", "salary": "60000"},
                        ]
                    ).encode("utf-8")
                )
            )
        }

        result = lambda_handler(event, None)

        expected_result = {
            "error": "Value error occurred: Invalid/missing data for department or salary.."
        }

        self.assertEqual(result["statusCode"], 400)
        self.assertEqual(json.loads(result["body"]), expected_result)

    @patch("lambda_function.boto3")
    def test_lambda_handler_department_invalid_missing_values(self, mock_boto3):
        # Define a sample event with missing or invalid department values
        event = {
            "Records": [
                {
                    "s3": {
                        "bucket": {"name": "test-bucket"},
                        "object": {"key": "test-file.json"},
                    }
                }
            ]
        }

        mock_s3 = MagicMock()
        mock_boto3.client.return_value = mock_s3
        mock_s3.get_object.return_value = {
            "Body": MagicMock(
                read=MagicMock(
                    return_value=json.dumps(
                        [
                            {"department": None, "salary": 50000},
                            {"department": "HR", "salary": None},
                            {"department": 32873, "salary": 55000},
                        ]
                    ).encode("utf-8")
                )
            )
        }

        result = lambda_handler(event, None)

        expected_result = {
            "error": "Value error occurred: Invalid/missing data for department or salary.."
        }

        self.assertEqual(result["statusCode"], 400)
        self.assertEqual(json.loads(result["body"]), expected_result)


if __name__ == "__main__":
    unittest.main()
