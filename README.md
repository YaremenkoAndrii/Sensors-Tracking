 
Exam Task for Salesforce Courses JETBI - Summer 2024 
( Variant 1 )

Task name: 
Sensors Tracking (Smart Workspace) 

Task description:
The task is to create an application with which you can understand the movement of the sensors. The motion of the sensors should be displayed on the custom interface (as a sheet with the current values of the sensors). The data on the sensor movements is sent via Postman. 

Data Model:


1. Create Custom object :Sensor__c
fields:
Name(text 80)
Max_Vectors_Length - Roll up summary

2. Create Custom object :Sensor_Event_c
fields:
Name- autonumber
Previous_Event_c - Lookup
Modulus_Vector_Length  - Formula(Number = √x2 + y2 + z 2)
Sensor - Master Details to Sensor


x - number
y - number
z - number

3. You need to create 5 records for the Sensors object with different Name values. 

4. If necessary, please create additional objects that don’t described in requirements. 


Profiles and Permissions:
1. Create IntegrationUser (could be assigned to your own email) with Profile “Integration Profile” and permission set with access to Sensor and sensor events access. 





Logic of sending sensor values:
1. Develop a REST POST service on the SF side that will accept a string with four vectors: '{‘sensorid’: '1', ‘vectors’: [{‘x’: 22,’y’: 17,’z’: 197}, {‘x’: 23, ‘y’: 45,’z’: 14}, { ‘x’: 22, ‘y’: 43,’z’: 196}, {‘x’: 24,‘y’: 42,‘z’: 198} ] }' 
This is your Sensor_Event_c 
2. The service should check if a sensor with Name == sensor id does not exist - then it should be created. Sensor Event records should also be generated.

Results display component:
1. You need to develop a Lightning Web Component that will contain a list with all Sensor Names on the org, and when you select a value, display a list of related in Sensor_Event_c and the Max_Vectors_Length field.
2. The application should be able to edit the vector data for each record of the associated Sensor_Event _c.


Necessary to use:
1) SOQL queries
2) Unit test coverage: at least 80%
3) Lightning application and lightning component
4) REST API and Postman (For REST service testing purposes use Postman.
Using Postman to test Salesforce API. )
5) Connected App


Recommended milestones:

After Block #1: Created a data model and test data. User created and permissions are assigned.
After Block #2: Component developed.
After Block #3: API work is configured.


All questions you can discuss on Lessons or Consultations with Tutors 





