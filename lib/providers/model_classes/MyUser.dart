import 'package:json_annotation/json_annotation.dart';

part 'MyUser.g.dart';

@JsonSerializable(explicitToJson: true)
class MyUser {
  final String? firstName;
  final String? lastName;
  final DateTime? DOB; //date of birth

  MyUser({
    required this.firstName,
    required this.lastName,
    required this.DOB,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}
