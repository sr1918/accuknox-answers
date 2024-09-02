import requests
import subprocess
import json


NAMESPACE = "default"  # We can change this to required namespace
FRONTEND_SERVICE = "frontend-service"
EXPECTED_MESSAGE = "Hello from the Backend!"

# Set the frontend URL to use the dynamically retrieved NodePort
FRONTEND_URL = f"http://localhost:8080"

# Test the frontend service
try:
    response = requests.get(FRONTEND_URL)
    response_text = response.text
except requests.exceptions.RequestException as e:
    print(f"Error: Could not retrieve the frontend service URL. {e}")
    exit(1)

# Check if the response matches the expected message
if EXPECTED_MESSAGE in response_text:
    print("Test Passed: The frontend service is correctly displaying the message from the backend.")
    exit(0)
else:
    print("Test Failed: The frontend service did not display the expected message.")
    print(f"Expected: {EXPECTED_MESSAGE}")
    print(f"Received: {response_text}")
    exit(1)

