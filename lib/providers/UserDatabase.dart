// ignore_for_file: file_names

import 'dart:async';
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

  MyUser user = MyUser(firstName: '', lastName: '', DOB: DateTime.now());

  List<StreamSubscription<DatabaseEvent>> listeners = [];

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

    //JUST LEARNED
    //actually does one value at a time
    final listener1 = ref.onChildChanged.listen((event) {
      print('CHANGED');
      String field = event.snapshot.key!;
      print(field);
      Object value = event.snapshot.value!;

      print(event.snapshot.value);
      if (field == 'firstName') {
        user = MyUser(
            firstName: value as String, lastName: user.lastName, DOB: user.DOB);
      } else if (field == 'lastName') {
        user = MyUser(
            firstName: user.firstName,
            lastName: value as String,
            DOB: user.DOB);
      } else if (field == 'DOB') {
        user = MyUser(
            firstName: user.firstName,
            lastName: user.lastName,
            DOB: DateTime.parse(value as String));
      }
    });
    listeners.add(listener1);
  }

  Future<void> cancelListeners() async {
    for (final listener in listeners) {
      await listener.cancel();
    }
  }

  Future<void> updateUser(MyUser myUser) async {
    user = myUser;
    String uid = UserState.user!.uid;
    print(uid);
    DatabaseReference ref = database.ref('users/${uid}');

    log('update user middle');
    log(myUser.toJson().toString());
    try {
      await ref.set(myUser.toJson());
    } on Exception catch (e) {
      print(e.toString());
    }
    log('update user finish');
  }
}
