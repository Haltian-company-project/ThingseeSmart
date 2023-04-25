import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thingseesmart/components/data_block.dart';

class ShowData extends StatelessWidget {
  List<dynamic> data;
  List<dynamic> date;
  ShowData({Key? key, required this.data, required this.date})
      : super(key: key);

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data history'),
        actions: [
          IconButton(
            onPressed: () {
              signUserOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date[index]);
          String formattedDate =
              DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);

          return Container(
            margin: EdgeInsets.all(8),
            child: ListTile(
              textColor: Colors.white,
              tileColor: Colors.blue.shade400,
              title: Center(
                  child: Text(
                data[index].toString(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
              subtitle: Column(
                children: [
                  Center(child: Text(formattedDate)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
