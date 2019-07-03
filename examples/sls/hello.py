import json
import sys
import platform


def handler(event, context):
    return {"statusCode": 200, "body": json.dumps({"sys": sys.version, "platform": platform.python_version()})}
