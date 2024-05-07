import json

def lambda_handler(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Dengue Forecast Application is Running!'),
        'headers': {
            'Content-Type': 'application/json',
        }
    }
