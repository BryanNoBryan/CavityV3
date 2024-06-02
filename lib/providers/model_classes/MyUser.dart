import 'package:json_annotation/json_annotation.dart';

import 'UserInfo.dart';

part 'MyUser.g.dart';

@JsonSerializable(explicitToJson: true)
class MyUser {
  final String uid;
  final UserInfo info;

  MyUser({
    required this.uid,
    required this.info,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}
