import 'dart:developer';

import 'package:cavity3/MyColors.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

import '../pdf/PDFRecord.dart';
import '../providers/UserDatabase.dart';
import '../providers/database.dart';
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
    pdfrecord =
        PDFRecord(records: Database().records!, user: UserDatabase().user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () async {
          try {
            Directory? directory;
            if (Platform.isIOS) {
              directory = await getApplicationDocumentsDirectory();
            } else {
              directory = Directory('/storage/emulated/0/Download');
              // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
              // ignore: avoid_slow_async_io
              if (!await directory.exists()) {
                directory = await getExternalStorageDirectory();
              }
            }

            // Get the directory to save the file
            final path = directory!.path;
            final file = File('$path/cavity.txt');

            // Write the file
            await file.writeAsString(
                '''${pdfrecord.user.firstName} ${pdfrecord.user.lastName}
${pdfrecord.user.DOB != null ? DateFormat.yMd().format(pdfrecord.user.DOB!) : 'DOB N/A'}
${pdfrecord.records.fold(
              '',
              (p, e) => '$p${e.disease} ${e.timestamp.toIso8601String()}\n',
            )}''');
          } catch (e) {
            log('file writing failed');
          }

          // print('press1');
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => PDFPreviewPage(pdfrecord: pdfrecord),
          //   ),
          // );
          // // rootBundle.
          // print('press2');
        },
        backgroundColor: MyColors.lightBlue,
        child: const Icon(Icons.picture_as_pdf, size: 36),
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
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${pdfrecord.user.firstName} ${pdfrecord.user.lastName}',
                      style: Theme.of(context).textTheme.headlineLarge,
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
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  ...pdfrecord.records.map(
                    (e) => ListTile(
                      title:
                          Text(DateFormat.yMd().add_jm().format(e.timestamp)),
                      trailing: Text(
                        e.disease,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.headlineLarge,
                    child: const Row(
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
