# Air Monitoring System

This project aims to monitor the air quality of various environments such as offices, schools, or any other indoor spaces, through sensors that send data via the MQTT protocol to a Node.js backend server. The server then forwards the data to a Firebase database, which can be accessed by certified users through a mobile app.

## Components
The system comprises the following components:

1. Sensor: This device collects data and sends it to the gateway.
2. Gateway: The gateway receives data from the sensor and sends it to the MQTT server.
3. MQTT server: This server manages the communication between the gateway and the Firebase database.
4. Node.js server: This server validates certificates and reads data from the MQTT server.
5. Firebase database: The sensor data is stored in this database and accessed through the Flutter app.

## Technologies Used
This system was built using the following technologies:

1. MQTT: This protocol was used for communication between the gateway and the MQTT server.
2. Node.js: This runtime environment was used to build the server that validates certificates and reads data from the MQTT server.
3. Firebase: This platform was used to store the sensor data and enable real-time data access.
4. Flutter: This framework was used to develop the mobile app that enables certified users to access the sensor data.

## How to Use
To use this system, follow the steps below:

1. Connect the sensor to the gateway.
2. Start the MQTT server.
3. Start the Node.js server by running `node index.js` in your terminal.
4. Configure the Firebase database.
5. Run the Flutter app.

The app will display real-time sensor data and the past 10 data history. Only certified users can access the sensor data.

## Contributors
This project was developed by Manish Panthi,Chapal Shaik,Divine Kweche and Purity Turunen . Feel free to contribute to the project by submitting a pull request.
