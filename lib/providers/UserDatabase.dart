// ignore_for_file: file_names

import 'dart:developer';

import 'package:cavity3/providers/user_state.dart';
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

  Future<void> initUser() async {
    print('trying to init user');
    String uid = UserState.user!.uid;
    DatabaseReference ref = database.ref('users/${uid}');

    final snapshot = await ref.get();
    if (snapshot.exists) {
      final json = Map<String, dynamic>.from(snapshot.value as Map);
      MyUser myUser = MyUser.fromJson(json);
      user = myUser;
    } else {
      //no
    }
    ref.onChildChanged.listen((event) {
      print('CHANGED');
      String? s = event.snapshot.key;
      print(s);
      event.snapshot.children.forEach((e) {
        print('${e.key} + ${e.value}');
      });

      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      final myUser = MyUser.fromJson(data);
      print('old user' + user!.toJson().toString());
      user = myUser;
      print('new user' + user!.toJson().toString());
    });
  }

  Future<void> updateUser(MyUser myUser) async {
    String uid = UserState.user!.uid;
    DatabaseReference ref = database.ref('users/${uid}');

    ref.set(myUser.toJson());
  }
}
