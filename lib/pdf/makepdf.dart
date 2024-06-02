// import 'dart:typed_data';

// import 'package:cavity3/pdf/PDFRecord.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'dart:io';
// import 'package:flutter/services.dart' show rootBundle;

// Future<Uint8List> makePdf(PDFRecord data) async {
//   final pdf = Document();
//   // final imageLogo = MemoryImage(
//   //     (await rootBundle.load('assets/images/icon.png')).buffer.asUint8List());
//   pdf.addPage(
//     Page(
//       build: (context) {
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Text('${data.user.firstName!} ${data.user.lastName!}'),
//                   ],
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                 ),
//                 // SizedBox(
//                 //   height: 150,
//                 //   width: 150,
//                 //   child: Image(imageLogo),
//                 // )
//               ],
//             ),
//             Container(height: 50),
//             Table(
//               border: TableBorder.all(color: PdfColors.black),
//               children: [
//                 TableRow(
//                   children: [
//                     Padding(
//                       child: Text(
//                         'Time',
//                         style: Theme.of(context).header4,
//                         textAlign: TextAlign.center,
//                       ),
//                       padding: EdgeInsets.all(20),
//                     ),
//                     Padding(
//                       child: Text(
//                         'Dental Disease',
//                         style: Theme.of(context).header4,
//                         textAlign: TextAlign.center,
//                       ),
//                       padding: EdgeInsets.all(20),
//                     ),
//                   ],
//                 ),
//                 ...data.records.map(
//                   (e) => TableRow(
//                     children: [
//                       Expanded(
//                         child: PaddedText(
//                             DateFormat.yMd().add_jm().format(e.timestamp)),
//                         flex: 2,
//                       ),
//                       Expanded(
//                         child: PaddedText(e.disease),
//                         flex: 1,
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               child: Text(
//                 "THANK YOU FOR USING CAVITY!",
//                 style: Theme.of(context).header2,
//               ),
//               padding: EdgeInsets.all(20),
//             ),
//             Text("Please forward the pdf to your dentist."),
//             Divider(
//               height: 1,
//               borderStyle: BorderStyle.dashed,
//             ),
//             Container(height: 50),
//             Padding(
//               padding: EdgeInsets.all(30),
//               child: Text(
//                 'Made with love by Bryan Liu\'24',
//                 style: Theme.of(context).header3.copyWith(
//                       fontStyle: FontStyle.italic,
//                     ),
//                 textAlign: TextAlign.center,
//               ),
//             )
//           ],
//         );
//       },
//     ),
//   );
//   return pdf.save();
// }

// Widget PaddedText(
//   final String text, {
//   final TextAlign align = TextAlign.left,
// }) =>
//     Padding(
//       padding: EdgeInsets.all(10),
//       child: Text(
//         text,
//         textAlign: align,
//       ),
//     );
