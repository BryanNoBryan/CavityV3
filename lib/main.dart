import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'navigation/MyNavigator.dart';
import 'providers/UserDatabase.dart';
import 'providers/app_state.dart';
import 'providers/user_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MyNavigator();

  // if (kDebugMode) {
  //   print('debug mode');
  //   try {
  //     FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);

  //     //NEVER FORGOT - THIS LINE WAS 8 HOURS OF DEBUGGING
  //     FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  //     //

  //     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print(e);
  //   }
  // }

  UserState();
  AppState();
  //init states before databases
  UserDatabase();
  //initialize records and user database records after login confirmed
  runApp(const MyApp());

  // //calculate after initializing
  //   MyNavigator.calculateNavigation();
}
