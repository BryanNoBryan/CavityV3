import 'package:cavity3/MyColors.dart';
import 'package:intl/intl.dart';

import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import '../navigation/MyNavigator.dart';
import '../pdf/PDFPreviewPage.dart';
import '../pdf/PDFRecord.dart';
import '../providers/UserDatabase.dart';
import '../providers/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PDFView extends StatefulWidget {
  const PDFView({super.key});

  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  late PDFRecord pdfrecord;

  @override
  void initState() {
    // TODO: implement initState
    pdfrecord =
        PDFRecord(records: Database().records!, user: UserDatabase().user!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          // print('press1');
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => PDFPreviewPage(pdfrecord: pdfrecord),
          //   ),
          // );
          // // rootBundle.
          // print('press2');
        },
        child: Icon(Icons.picture_as_pdf, size: 36),
        backgroundColor: MyColors.lightBlue,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Patient',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${pdfrecord.user.firstName} ${pdfrecord.user.lastName}',
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Column(
                children: [
                  Text(
                    'Records',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  ...pdfrecord.records.map(
                    (e) => ListTile(
                      title:
                          Text(DateFormat.yMd().add_jm().format(e.timestamp)),
                      trailing: Text(
                        e.disease,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.headline4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("PDF"),
                        Text(
                          'REPORT',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
