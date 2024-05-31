import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';

import 'model_classes/Record.dart';
import 'user_state.dart';

class Database {
  static final Database _state = Database._init();
  factory Database() {
    return _state;
  }
  Database._init();

  FirebaseDatabase database = FirebaseDatabase.instance;
  List<Record>? records;

  List<Record>? getCourses() {
    print('course got');
    return [];
  }

  Future<void> addRecord(Record record) async {
    String uid = UserState.user!.uid;
    DatabaseReference ref = database.ref('records/${uid}');
    int time = DateTime.now().millisecondsSinceEpoch;
    ref.set({
      time.toString(): {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'disease': 1,
      }
    });
  }

  Future<void> editCourse(Record course) async {
    // FirebaseFirestore.instance
    //     .collection('Courses')
    //     .doc(course.code)
    //     .set(course.toFirestore())
    //     .onError((error, stackTrace) => print('$error'));
    // print('edit course');
  }

  Future<void> retrieveCourses() async {
    // print('course retrieved');
    // //do once() later
    // String uid = UserState.user!.uid;
    // DatabaseReference ref = database.ref('records/${uid}');
    // final snapshot = await ref.orderByChild('timestamp').get();
    // snapshot.children.
  }

  Future<void> deleteCourse(Record course) async {
    // await FirebaseFirestore.instance
    //     .collection('Courses')
    //     .doc(course.code)
    //     .delete()
    //     .then(
    //       (doc) => print("Document deleted"),
    //       onError: (e) => print("Error updating document $e"),
    //     );
    // print('finished deleting');
  }

  Future<List<Record>?> updateList(String code) async {
    // var doc =
    //     await FirebaseFirestore.instance.collection('Courses')
    // .doc(code).get();
    // if (!doc.exists) {
    //   log('doc in update list exists');
    //   log('code $code');
    //   for (int i = 0; i < courses!.length; i++) {
    //     log('each code ${courses![i].code}');
    //     if ((courses![i].code ?? '') == code) {
    //       courses!.removeAt(i);
    //       log('${courses} removedd thingys DID IT DO IT? $i ');
    //       printList();
    //       break;
    //     }
    //   }
    // } else {
    //   log('other');
    //   Record course = Record.fromFirestore(doc, null);
    //   for (int i = 0; i < courses!.length; i++) {
    //     if (courses![i].code == code) {
    //       courses![i] = course;
    //       break;
    //     }
    //   }
    //   if (queriedCourses != null) {
    //     for (int i = 0; i < queriedCourses!.length; i++) {
    //       if (queriedCourses![i].code == code) {
    //         queriedCourses![i] = course;
    //         break;
    //       }
    //     }
    //   }
    //   print(course.prereq);
    // }

    // print('called update list');
    // printList();
    // return courses;
  }
}
