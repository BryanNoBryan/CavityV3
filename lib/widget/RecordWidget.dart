import 'package:flutter/material.dart';

import '../MyColors.dart';

import 'package:intl/intl.dart';

class RecordWidget extends StatelessWidget {
  const RecordWidget(
      {required this.time,
      required this.disease,
      required this.onswipe,
      super.key});

  //maybe index for list view
  final DateTime time;
  final String disease;
  final Function() onswipe;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        //remove from DB

        //DOODODOODODODODDOD
      },
      child: Container(
        height: 120,
        width: 360,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: MyColors.lightBlue,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blueAccent)),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MM-dd-yyyy').format(time),
              style: TextStyle(fontSize: 26),
            ),
            Text(
              disease,
              style: TextStyle(fontSize: 26),
            )
          ],
        ),
      ),
    );
  }
}
