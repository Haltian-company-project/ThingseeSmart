import 'package:flutter/material.dart';

class DataBlock extends StatelessWidget {
  dynamic data;
  String name;
  int lower_range;
  int upper_range;
  String statusOne;
  String statusTwo;
  DataBlock({
    Key? key,
    required this.data,
    required this.name,
    required this.lower_range,
    required this.upper_range,
    required this.statusOne,
    required this.statusTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Carbon Dioxide
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center, // center the text
            ),
            SizedBox(height: 10), // add some spacing between the texts
            Text(
              data.toString(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              lower_range >= data && data <= upper_range
                  ? statusOne
                  : statusTwo,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
