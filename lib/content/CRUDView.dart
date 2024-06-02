import 'dart:developer';

import '../providers/model_classes/MyRecord.dart';
import '../widget/RecordWidget.dart';

import '../MyColors.dart';
import '../navigation/MyNavigator.dart';
import '../providers/UserDatabase.dart';
import '../providers/database.dart';
import '../providers/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:provider/provider.dart';

class CRUDView extends StatefulWidget {
  const CRUDView({super.key});

  @override
  State<CRUDView> createState() => _CRUDViewState();
}

class _CRUDViewState extends State<CRUDView> {
  List<MyRecord>? records;

  @override
  void initState() {
    // TODO: implement initState
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
