**Frontend-Backend Integration Test Script**

This project includes a Python script designed to test the integration between frontend and backend services within a Kubernetes environment. The script verifies whether the frontend service correctly displays the message received from the backend service.

**Prerequisites**
Before running the script, ensure that the following software is installed on your machine:

Python 3.x:

Download Python from the official website.
Verify the installation by running:

python3 --version

pip: Python's package installer should be available by default with Python 3.x.

**The script requires the requests library for making HTTP requests.**

Install it using pip:

pip install requests

**To set up the environment and run the test script, follow these steps:**

Clone the Repository:
git clone https://github.com/sr1918/accuknox-answers.git
cd frontend-backend-integration-test

**Ensure Kubernetes is Running:**

Make sure your Kubernetes cluster is up and running, and that the frontend and backend services are properly deployed.

And also make sure to forward the port required for frontend service using below command if you don't have cloud service providers

kubectl port-forward svc/frontend-service 8080:80 -n default

NOTE: If you're using a cloud service provider, please edit the frontend url portion accordingly with the given port in the script.


**Execute the Python script to perform the integration test:**
python3 validate.py
Test Results
After running the script, you will see one of the following outputs:

**Test Passed**
Test Passed: The frontend service is correctly displaying the message from the backend.

**Test Failed**
Test Failed: The frontend service did not display the expected message.
Expected: Hello from the Backend!
Received: <actual message>
If the test fails, the output will include the expected message and the actual response received, which can help in troubleshooting the issue.

**Troubleshooting**

Connection Errors: If the script cannot connect to the frontend service, ensure that the service is running and accessible at the specified URL.
Incorrect Message: If the expected message does not match the actual message, check the backend service to ensure it is functioning correctly.
