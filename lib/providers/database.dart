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

  Future<void> initRecords() async {
    records = [];
    String uid = UserState.user!.uid;
    DatabaseReference ref = database.ref('records/${uid}');

    //NOTE: APPARENTLY IF YOU HAVE ref.onChildAdded.listen, it both listens to changes AND
    //adds in what is already there, oh well I'll keep this here for now

    // final snapshot = await ref.get();

    // if (snapshot.exists) {
    //   final json = Map<String, dynamic>.from(snapshot.value as Map);
    //   json.keys.toList().forEach((elem) {
    //     final dataForThisRecord = Map<String, dynamic>.from(json[elem] as Map);

    //     MyRecord record = MyRecord.fromJson(dataForThisRecord);
    //     record.key = elem;

    //     //TODO DO SORTING TO ADD IN, might not need alr sorted
    //     records!.add(record);
    //   });
    // } else {
    //   //no
    // }

    //listen to changes
    ref.onChildAdded.listen((event) {
      String? key = event.snapshot.key;
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      final record = MyRecord.fromJson(data);
      record.key = key;

      records!.insert(0, record);
    });

    ref.onChildRemoved.listen((event) {
      String? key = event.snapshot.key;
      for (int i = 0; i < records!.length; i++) {
        if (records![i].key! == key) {
          records!.removeAt(i);
          break;
        }
      }
    });
  }

  //no need to implement for now
  // ref.onChildChanged.listen((event) {});

  Future<void> deleteRecord(MyRecord record) async {
    String uid = UserState.user!.uid;
    String path = record.key!;
    DatabaseReference ref = database.ref('records/${uid}/${path}');
    ref.remove();
    print('DELETED record');
  }

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
  }

  //no need for now
  Future<void> editRecord(MyRecord record) async {}
}
