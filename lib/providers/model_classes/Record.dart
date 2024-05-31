// ignore_for_file: file_names
import 'dart:core';

import 'Disease.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:firebase_database/firebase_database.dart';

part 'Record.g.dart';

@JsonSerializable(explicitToJson: true)
class Record {
  final DateTime timestamp;
  final Disease disease;

  Record({
    required this.timestamp,
    required this.disease,
  });

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);
}
