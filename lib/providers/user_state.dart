import 'dart:developer';

import 'package:cavity3/navigation/MyNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/foundation.dart';

import 'UserDatabase.dart';
import 'database.dart';

class UserState extends ChangeNotifier {
  static final UserState _userState = UserState._init();

  factory UserState() {
    return _userState;
  }

  static const String SUPERADMIN = 'super-admin';
  static const String ADMIN = 'admin';
  static const String REGULAR = 'regular';

  static User? _user;
  static User? get user => _user;

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  bool _verified = false;
  bool get verified => _verified;

  bool init = false;

  UserState._init() {
    if (init == true) return;
    init = true;
    //I need this information immediately
    _loggedIn = FirebaseAuth.instance.currentUser != null;
    _verified =
        (_loggedIn && FirebaseAuth.instance.currentUser!.emailVerified == true);
    log('info initialized in init');
    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null) {
        _user = user;
        _loggedIn = true;

        if (user.emailVerified) {
          _verified = true;
          log('verified');
          await MyNavigator.calculateNavigation();
        } else {
          _verified = false;
          await MyNavigator.calculateNavigation();
        }
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }

  Future<void> logout() async {
    log('logged out');
    Database().cancelListeners();
    UserDatabase().cancelListeners();
    init = false;
    Database().init = false;
    await FirebaseAuth.instance.signOut();
    _verified = false;
    _user = null;
    // MyNavigator.router.go(MyNavigator.CourseViewPath);
  }
}
