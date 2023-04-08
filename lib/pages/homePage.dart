import 'package:flutter/material.dart';
import 'package:thingseesmart/pages/auth_page.dart';
import 'package:thingseesmart/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get child => null;

  @override
  // TODO: implement widget
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThingeseeSmart'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/ThingSeeSmart.png',
            fit: BoxFit.contain,
            height: 300,
          ),
          const SizedBox(
            height: 70,
          ),
          const Text(
            'Impossible Things Made Easy',
            style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 16, 16, 17),
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: MaterialButton(
              minWidth: double.infinity,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AuthPage();
                }));
              },
              child: Text('Login'),
              color: const Color.fromARGB(255, 16, 130, 224),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void login() {}
}
