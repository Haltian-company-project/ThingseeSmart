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
    var menu;
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Dash Board')),
          leading: IconButton(
            onPressed: () {
              menu = !menu;
            },
            icon: const Icon(Icons.menu),
          ),
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AllCharts()));
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
              return const Text('Loading...');
            }

            var bib = snapshot.data!.docs.first.data() as Map<String, dynamic>;
            var todate = bib['timestamp'].toDate();
            String formattedDate =
                DateFormat('yyyy-MM-dd hh:mm:ss a').format(todate);
            // print( bib );
            print(todate.millisecondsSinceEpoch.toDouble());

            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DataBlock(
                      data: bib['carbonDioxide'],
                      name: "Carbon Dioxide",
                      lower_range: 600,
                      upper_range: 800,
                      statusOne: "Good",
                      statusTwo: "Bad",
                      icon: const Icon(Icons.airline_seat_flat_angled),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['tvoc'],
                    name: "TVOC",
                    lower_range: 30,
                    upper_range: 800,
                    statusOne: "Good",
                    statusTwo: "Bad",
                    icon: Icon(
                        const IconData(0xf542, fontFamily: 'MaterialIcons'),
                        color: Colors.blue.shade600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['humd'],
                    name: "Humidity",
                    lower_range: 30,
                    upper_range: 40,
                    statusOne: "Good",
                    statusTwo: "Bad",
                    icon: const Icon(Icons.airline_seat_flat_angled),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['temp'],
                    name: "Temperature",
                    lower_range: 20,
                    upper_range: 22,
                    statusOne: "good",
                    statusTwo: "bad",
                    icon: const Icon(Icons.airline_seat_flat_angled),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['airp'],
                    name: "Air Pressure",
                    lower_range: 980000,
                    upper_range: 1030000,
                    statusOne: "Good",
                    statusTwo: "Bad",
                    icon: const Icon(Icons.airline_seat_flat_angled),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['in'],
                    name: "People In",
                    lower_range: 0,
                    upper_range: 0,
                    statusOne: "",
                    statusTwo: "",
                    icon: const Icon(Icons.airline_seat_flat_angled),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['out'],
                    name: "People Out",
                    lower_range: 800,
                    upper_range: 1000,
                    statusOne: "Good",
                    statusTwo: "Bad",
                    icon: const Icon(Icons.airline_seat_flat_angled),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataBlock(
                    data: bib['historicalIn'],
                    name: "Historical In",
                    lower_range: 800,
                    upper_range: 1000,
                    statusOne: "Good",
                    statusTwo: "Bad",
                    icon: const Icon(Icons.airline_seat_flat_angled),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
