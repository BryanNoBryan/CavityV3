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

  String? checkUID(MyUser user) {
    // String? s = user.UID ?? UserState.user?.uid;
    // print('checkUID: $s');
    return '';
  }

  MyUser? getUser() {
    // log('got user ${user?.firstName}  ${user?.UID}');
    return user;
  }

  Future<MyUser?> retrieveUser() async {
    // print(UserState.user?.uid);
    // user = MyUser.fromFirestore(
    //     await FirebaseFirestore.instance
    //         .collection('Users')
    //         .doc(UserState.user?.uid)
    //         .get(),
    //     null);

    // log('retrieved user');
    // log('retrieved user ${user?.firstName}  ${user?.UID}');
    // return user;
  }

  Future<void> updateUser(MyUser user) async {
    // String? UID = checkUID(user);
    // if (UID == null) {
    //   print('UID NULL1');
    //   return;
    // }

    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(UID)
    //     .set(user.toFirestore())
    //     .onError((error, stackTrace) => print('$error'));
    // print('update user');
  }
}
