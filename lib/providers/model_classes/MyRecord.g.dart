// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyRecord.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyRecord _$MyRecordFromJson(Map<String, dynamic> json) => MyRecord(
      timestamp: MyRecord._fromJson((json['timestamp'] as num).toInt()),
      disease: json['disease'] as String,
    );

Map<String, dynamic> _$MyRecordToJson(MyRecord instance) => <String, dynamic>{
      'timestamp': MyRecord._toJson(instance.timestamp),
      'disease': instance.disease,
    };
