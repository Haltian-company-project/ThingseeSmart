import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'data_show.dart';

class AllCharts extends StatelessWidget {
  const AllCharts({Key? key}) : super(key: key);
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    List<dynamic>? carbonDioxideData = [];
    List<dynamic>? timestamp = [];
    List<dynamic>? temperatureData = [];
    List<dynamic>? humidityData = [];
    List<dynamic>? pressureData = [];
    List<dynamic>? tvoccData = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Graph View'),

        actions: [
          IconButton(
            onPressed: () {
              signUserOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('data').orderBy('timestamp', descending: true).limit(15).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text('Error is ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          carbonDioxideData = snapshot.data?.docs.map((doc) => (doc.data() as Map<String, dynamic>)['carbonDioxide']).toList();
          temperatureData = snapshot.data?.docs.map((doc) => (doc.data() as Map<String, dynamic>)['temp']).toList();
          humidityData = snapshot.data?.docs.map((doc) => (doc.data() as Map<String, dynamic>)['humd']).toList();
          pressureData = snapshot.data?.docs.map((doc) => (doc.data() as Map<String, dynamic>)['airp']).toList();
          tvoccData = snapshot.data?.docs.map((doc) => (doc.data() as Map<String, dynamic>)['tvoc']).toList();
          timestamp = snapshot.data?.docs.map((doc) => (doc.data() as Map<String, dynamic>)['timestamp'].toDate().millisecondsSinceEpoch).toList();

          List<FlSpot>? data = snapshot.data?.docs.reversed.map((doc){
            return FlSpot(
              (doc.data() as Map<String, dynamic>)['timestamp'].toDate().millisecondsSinceEpoch.toDouble(),
              (doc.data() as Map<String, dynamic>)['carbonDioxide'].toDouble(),
            );
          }).toList();

          List<FlSpot>? tempData = snapshot.data?.docs.reversed.map((doc){
            return FlSpot(
              (doc.data() as Map<String, dynamic>)['timestamp'].toDate().millisecondsSinceEpoch.toDouble(),
              (doc.data() as Map<String, dynamic>)['temp'].toDouble(),
            );
          }).toList();

          List<FlSpot>? tvocData = snapshot.data?.docs.reversed.map((doc){
            return FlSpot(
              (doc.data() as Map<String, dynamic>)['timestamp'].toDate().millisecondsSinceEpoch.toDouble(),
              (doc.data() as Map<String, dynamic>)['tvoc'].toDouble(),
            );
          }).toList();

          List<FlSpot>? humdData = snapshot.data?.docs.reversed.map((doc){
            return FlSpot(
              (doc.data() as Map<String, dynamic>)['timestamp'].toDate().millisecondsSinceEpoch.toDouble(),
              (doc.data() as Map<String, dynamic>)['humd'].toDouble(),
            );
          }).toList();

          List<FlSpot>? airpData = snapshot.data?.docs.reversed.map((doc){
            return FlSpot(
              (doc.data() as Map<String, dynamic>)['timestamp'].toDate().millisecondsSinceEpoch.toDouble(),
              (doc.data() as Map<String, dynamic>)['airp'].toDouble(),
            );
          }).toList();

          print(carbonDioxideData);

          return
            ListView(
              children: [
                //carbon dioxide
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Carbon Dioxide', style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 16),
                SizedBox(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LineChart(
                          LineChartData(
                              minX: data!.isNotEmpty ? data.first.x : 0,
                              maxX: data.isNotEmpty ? data.last.x : 0,
                              minY: data.isNotEmpty ? data.reduce((a, b) => a.y < b.y ? a : b).y - 500 : 0,
                              maxY: data.isNotEmpty ? data.reduce((a, b) => a.y > b.y ? a : b).y + 500 : 0,
                              lineBarsData: [
                                LineChartBarData(spots: data, isCurved: false, ),
                              ],
                              titlesData: FlTitlesData(
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 22,
                                        getTitlesWidget: (value, meta) {
                                          return Flexible(
                                            child: Text(
                                              DateFormat('dd').format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Color(0xff72719b),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                  ),
                                  topTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: false,
                                      )
                                  ),
                                  rightTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: false,
                                      )
                                  )
                              )

                          )
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowData(data: carbonDioxideData!.toList(), date: timestamp!.toList(),)),
                      );
                    },
                    child: Text('Show Data', style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2
                    ),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue.shade600),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ),

                //tvoc
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('TVOC', style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineChart(
                        LineChartData(
                            minX: tvocData!.isNotEmpty ? tvocData.first.x : 0,
                            maxX: tvocData.isNotEmpty ? tvocData.last.x : 0,
                            minY: tvocData.isNotEmpty ? tvocData.reduce((a, b) => a.y < b.y ? a : b).y - 30 : 0,
                            maxY: tvocData.isNotEmpty ? tvocData.reduce((a, b) => a.y > b.y ? a : b).y + 30 : 0,
                            lineBarsData: [
                              LineChartBarData(spots: tvocData, isCurved: false, ),
                            ],
                            titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 22,
                                      getTitlesWidget: (value, meta) {
                                        return Flexible(
                                          child: Text(
                                            DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Color(0xff72719b),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                ),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: false
                                    )
                                ),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: false
                                    )
                                )
                            )

                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowData(data: tvoccData!.toList(), date: timestamp!.toList(),)),
                      );
                    },
                    child: Text('Show Data', style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2
                    ),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue.shade600),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ),

                //temperature
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Temperature', style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineChart(
                        LineChartData(
                            minX: tempData!.isNotEmpty ? tempData.first.x : 0,
                            maxX: tempData.isNotEmpty ? tempData.last.x : 0,
                            minY: tempData.isNotEmpty ? tempData.reduce((a, b) => a.y < b.y ? a : b).y - 30 : 0,
                            maxY: tempData.isNotEmpty ? tempData.reduce((a, b) => a.y > b.y ? a : b).y + 30 : 0,
                            lineBarsData: [
                              LineChartBarData(spots: tempData, isCurved: false, ),
                            ],
                            titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 22,
                                      getTitlesWidget: (value, meta) {
                                        return Flexible(
                                          child: Text(
                                            DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Color(0xff72719b),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                ),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: false
                                    )
                                ),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: false
                                    )
                                )
                            )

                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowData(data: temperatureData!.toList(), date: timestamp!.toList(),)),
                      );
                    },
                    child: Text('Show Data', style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2
                    ),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue.shade600),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ),

                //humidity
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Humidity', style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineChart(
                        LineChartData(
                            minX: humdData!.isNotEmpty ? humdData.first.x : 0,
                            maxX: humdData.isNotEmpty ? humdData.last.x : 0,
                            minY: humdData.isNotEmpty ? humdData.reduce((a, b) => a.y < b.y ? a : b).y - 30 : 0,
                            maxY: humdData.isNotEmpty ? humdData.reduce((a, b) => a.y > b.y ? a : b).y + 30 : 0,
                            lineBarsData: [
                              LineChartBarData(spots: humdData, isCurved: false, ),
                            ],
                            titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 22,
                                      getTitlesWidget: (value, meta) {
                                        return Flexible(
                                          child: Text(
                                            DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Color(0xff72719b),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                ),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: false
                                    )
                                ),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: false
                                    )
                                )
                            )

                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowData(data: humidityData!.toList(), date: timestamp!.toList(),)),
                      );
                    },
                    child: Text('Show Data', style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2
                    ),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue.shade600),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ),

                //Air peressure
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Air Pressure', style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LineChart(
                        LineChartData(
                            minX: airpData!.isNotEmpty ? airpData.first.x : 0,
                            maxX: airpData.isNotEmpty ? airpData.last.x : 0,
                            minY: airpData.isNotEmpty ? airpData.reduce((a, b) => a.y < b.y ? a : b).y - 10000 : 0,
                            maxY: airpData.isNotEmpty ? airpData.reduce((a, b) => a.y > b.y ? a : b).y + 10000 : 0,
                            lineBarsData: [
                              LineChartBarData(spots: airpData, isCurved: false, ),
                            ],
                            titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 22,
                                      getTitlesWidget: (value, meta) {
                                        return Flexible(
                                          child: Text(
                                            DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Color(0xff72719b),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                ),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: false
                                    )
                                ),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles: false
                                    )
                                )
                            )

                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowData(data: pressureData!.toList(), date: timestamp!.toList(),)),
                      );
                    },
                    child: Text('Show Data', style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2
                    ),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue.shade600),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ),

              ],
            );
        },
      ),
    );
  }
}
