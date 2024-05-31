// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) => MyUser(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      DOB: json['DOB'] == null ? null : DateTime.parse(json['DOB'] as String),
    );

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'DOB': instance.DOB?.toIso8601String(),
    };
