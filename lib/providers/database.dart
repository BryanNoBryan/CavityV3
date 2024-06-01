import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';

import 'model_classes/MyRecord.dart';
import 'user_state.dart';

class Database {
  static final Database _state = Database._init();
  factory Database() {
    return _state;
  }
  Database._init();

  FirebaseDatabase database = FirebaseDatabase.instance;
  List<MyRecord>? records;

  Future<List<MyRecord>?> initCourses() async {
    String uid = UserState.user!.uid;
    DatabaseReference ref = database.ref('records/${uid}');
    final snapshot = await ref.get();

    //initialize
    records = [];
    if (snapshot.exists) {
      Map<String, dynamic> json = jsonDecode(snapshot.value as String);
      json.keys.toList().forEach((elem) {
        MyRecord record = MyRecord.fromJson(json[elem]);
        record.key = elem;

        //TODO DO SORTING TO ADD IN
        records!.add(record);
      });
    } else {
      //no
    }

    //TODO DO SORTING TO ADD IN

    //listen to changes
    ref.onChildAdded.listen((event) {
      // A new comment has been added, so add it to the displayed list.
    });
    ref.onChildChanged.listen((event) {
      // A comment has changed; use the key to determine if we are displaying this
      // comment and if so displayed the changed comment.
    });
    ref.onChildRemoved.listen((event) {
      // A comment has been removed; use the key to determine if we are displaying
      // this comment and if so remove it.
    });
  }

  void addInOrder() {}

  // List<MyRecord>? getCourses() {
  //   String uid = UserState.user!.uid;
  //   DatabaseReference ref = database.ref('records/${uid}');

  //   ref.onValue.listen((DatabaseEvent event) {
  //     final data = event.snapshot.value;
  //     event.type
  //   });
  // }

  Future<String?> addRecord(MyRecord record) async {
    print('trying to add record');
    String uid = UserState.user!.uid;
    DatabaseReference ref = database.ref('records/${uid}');
    DatabaseReference push = ref.push();
    String? key = push.key;

    push.set(record.toJson());
    print(record.toJson().toString());
    print('added record key = ${key}');

    //ref to be able to delete
    return key;

    //then add somewhere for local optimization
  }

  Future<void> editCourse(MyRecord course) async {
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

  Future<void> deleteCourse(MyRecord course) async {
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

  Future<List<MyRecord>?> updateList(String code) async {
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
