// ignore_for_file: file_names

import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:firebase_database/firebase_database.dart';

part 'Disease.g.dart';

@JsonSerializable(explicitToJson: true)
class Disease {
  final String disease;

  Disease({
    required this.disease,
  });

  factory Disease.fromJson(Map<String, dynamic> json) =>
      _$DiseaseFromJson(json);

  Map<String, dynamic> toJson() => _$DiseaseToJson(this);
}
