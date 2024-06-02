import 'package:cavity3/providers/model_classes/MyRecord.dart';

import '../providers/model_classes/MyUser.dart';

class PDFRecord {
  List<MyRecord> records;
  MyUser user;

  PDFRecord({required this.records, required this.user});
}
