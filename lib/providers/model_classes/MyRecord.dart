// ignore_for_file: file_names
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'MyRecord.g.dart';

//I'm doing my own
@JsonSerializable(explicitToJson: true)
class MyRecord {
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime timestamp;
  final String disease;

  //avoid nested JSON classes, just do this for simplicity for now
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? key;

  MyRecord({required this.timestamp, required this.disease, this.key});

  factory MyRecord.fromJson(Map<String, dynamic> json) =>
      _$MyRecordFromJson(json);

  Map<String, dynamic> toJson() => _$MyRecordToJson(this);

  static DateTime _fromJson(int time) =>
      DateTime.fromMillisecondsSinceEpoch(time);
  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;
}
