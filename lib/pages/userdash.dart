import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDash extends StatelessWidget {
  UserDash({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
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
      body: Container(
        child: SizedBox(
          height: 150,
          width: 500,
          child: Card(
            elevation: 10,
            margin: const EdgeInsets.symmetric(
                horizontal: 35, vertical: 15), // adds a shadow to the card
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'C02',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      ' 1024 ppm ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
