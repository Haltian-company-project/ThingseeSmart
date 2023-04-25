import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thingseesmart/components/data_block.dart';
import 'package:thingseesmart/pages/all_charts.dart';

class SingleChart extends StatelessWidget {
  const SingleChart({Key? key}) : super(key: key);
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dash Board'),

          actions: [
            IconButton(
              onPressed: () {
                signUserOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AllCharts()));
          },
          child: Icon(
            Icons.multiline_chart,
            color: Colors.blue.shade600,
          ),
          backgroundColor: Colors.white,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('data')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error is: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }

            var bib = snapshot.data!.docs.first.data() as Map<String, dynamic>;
            var todate = bib['timestamp'].toDate();
            String formattedDate =
                DateFormat('yyyy-MM-dd hh:mm:ss a').format(todate);
            // print( bib );
            print(todate.millisecondsSinceEpoch.toDouble());

            // Text('totalIn: ${bib['totalIn']}'),
            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['carbonDioxide'],
                    name: "Carbon Dioxide",
                    range: 800,
                    statusOne: "Good",
                    statusTwo: "Bad",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['tvoc'],
                    name: "TVOC",
                    range: 300,
                    statusOne: "Good",
                    statusTwo: "Bad",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['humd'],
                    name: "Humidity",
                    range: 300,
                    statusOne: "Good",
                    statusTwo: "Bad",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['temp'],
                    name: "Temperature",
                    range: 300,
                    statusOne: "Good",
                    statusTwo: "Bad",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['in'],
                    name: "In",
                    range: 300,
                    statusOne: "Good",
                    statusTwo: "Bad",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['out'],
                    name: "Out",
                    range: 300,
                    statusOne: "Good",
                    statusTwo: "Bad",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['airp'],
                    name: "Air Pressure",
                    range: 300,
                    statusOne: "Good",
                    statusTwo: "Bad",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['historicalIn'],
                    name: "Historical In",
                    range: 300,
                    statusOne: "Good",
                    statusTwo: "Bad",
                  ),
                ),
              ],
            );
          },
        ));
  }
}
