// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) => Record(
      timestamp: DateTime.parse(json['timestamp'] as String),
      disease: Disease.fromJson(json['disease'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'disease': instance.disease.toJson(),
    };
