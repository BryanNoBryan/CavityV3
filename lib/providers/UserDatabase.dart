// ignore_for_file: file_names

import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

import 'model_classes/MyUser.dart';

class UserDatabase {
  static final UserDatabase _state = UserDatabase._init();
  factory UserDatabase() {
    return _state;
  }
  UserDatabase._init();

  MyUser? user;

  FirebaseDatabase database = FirebaseDatabase.instance;

  MyUser? getUser() {
    return user;
  }
}
