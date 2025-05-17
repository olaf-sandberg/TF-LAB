import json

def lambda_handler(event, context):
    print("GuardDuty Event Triggered:")
    print(json.dumps(event, indent=2))
    return {"status": "ok"}