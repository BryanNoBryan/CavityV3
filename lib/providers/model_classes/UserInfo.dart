import 'package:json_annotation/json_annotation.dart';

part 'UserInfo.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInfo {
  final String? firstName;
  final String? lastName;
  final DateTime? DOB; //date of birth

  UserInfo({
    this.firstName,
    this.lastName,
    this.DOB,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
