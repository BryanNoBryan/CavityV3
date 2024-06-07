import '../providers/model_classes/MyRecord.dart';
import '../widget/RecordWidget.dart';

import '../MyColors.dart';
import '../providers/database.dart';
import 'package:flutter/material.dart';

class CRUDView extends StatefulWidget {
  const CRUDView({super.key});

  @override
  State<CRUDView> createState() => _CRUDViewState();
}

class _CRUDViewState extends State<CRUDView> {
  List<MyRecord>? records;

  @override
  void initState() {
    super.initState();
    // courses = Database().getCourses();
    // print(courses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit History"),
        centerTitle: true,
        backgroundColor: MyColors.green,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.keyboard_arrow_left),
                  Text(
                    'Swipe Horizontally to Delete!',
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: Database().records?.length ?? 0,
                itemBuilder: (context, idx) {
                  MyRecord record = Database().records![idx];
                  return RecordWidget(
                      time: record.timestamp,
                      disease: record.disease,
                      onswipe: () async {
                        await Database().deleteRecord(record);
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
