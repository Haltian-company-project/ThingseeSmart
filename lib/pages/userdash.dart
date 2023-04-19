import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'dart:convert';

class UserDash extends StatefulWidget {
  const UserDash({super.key});

  @override
  State<UserDash> createState() => _UserDashState();
}

class _UserDashState extends State<UserDash> {
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic> data = {};

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void fetchData() {
    try {
      Socket socket = io(
          'https://3682-2001-14bb-692-7463-bc41-f23d-850a-8b63.eu.ngrok.io',
          OptionBuilder().setTransports(['websocket']).build());
      socket.onConnect((_) {
        print('connected');
      });
      socket.on(
          'readings',
          (jsonData) => setState(() {
                // print(jsonData);
                data = jsonDecode(jsonData);
              }));
      socket.onDisconnect((_) => print('disconnect'));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThingSee Smart'),
        actions: [
          IconButton(
            onPressed: () {
              signUserOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text('Historical In'),
                  Text('${data['historicalIn'] ?? '0'}'),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text('Historical Out'),
                  Text('${data['historicalOut'] ?? '0'}'),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text('Carbon Dioxide'),
                  Text('${data['carbonDioxide'] ?? '0'}'),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text('TVOC'),
                  Text('${data['tvoc'] ?? '0'}'),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text('Temprature'),
                  Text('${data['temp'] ?? '0'}'),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text('humd'),
                  Text('${data['humd'] ?? '0'}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
