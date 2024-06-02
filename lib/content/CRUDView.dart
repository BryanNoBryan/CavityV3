import 'dart:developer';

import '../providers/model_classes/MyRecord.dart';
import '../widget/RecordWidget.dart';

import '../MyColors.dart';
import '../navigation/MyNavigator.dart';
import '../providers/UserDatabase.dart';
import '../providers/database.dart';
import '../providers/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:provider/provider.dart';

class CRUDView extends StatefulWidget {
  const CRUDView({super.key});

  @override
  State<CRUDView> createState() => _CRUDViewState();
}

class _CRUDViewState extends State<CRUDView> {
  List<MyRecord>? records;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // courses = Database().getCourses();
    // print(courses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit History"),
        centerTitle: true,
        backgroundColor: MyColors.green,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.keyboard_arrow_left),
                  Text(
                    'Swipe Horizontally to Delete!',
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: Database().records?.length ?? 0,
                itemBuilder: (context, idx) {
                  MyRecord record = Database().records![idx];
                  return RecordWidget(
                      time: record.timestamp,
                      disease: record.disease,
                      onswipe: () async {
                        await Database().deleteRecord(record);
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


// ElevatedButton(
//             onPressed: () async {
//               Course c = Course(
//                   code: 'HFN11XA',
//                   name: 'AP MACRO ECON',
//                   description: '''
// Macroeconomics is the theory of the free market that looks at the economy as a whole. It includes
// national income and price determination, economic performance measures, economic growth
// and international economics. Money, banking, monetary policy and inflation are important topics.
// Additional topics, lessons and assignments will satisfy the requirements for Participation in
// Government.
// Students who take the course may take the AP Exam in May.
// ''',
//                   timeDesc:
//                       '(5 periods per week for 1 year - Qualified Entry Required)',
//                   level: 'AP',
//                   prereq: ['test1'],
//                   coreq: ['test1'],
//                   tags: ['test1']);

//               await Database().addCourse(c);
//               Database().retrieveCourses();

//               print(
//                   'courses:' + courses.toString() + courses!.length.toString());
//               print(courses != null ? courses!.length : 0);
//               setState(() {});
//             },
//             child: Text("add course"),
//           ),


// final RegExp _emailRegex = RegExp(r'^\S+@\S+$');

//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   TextEditingController emailController = TextEditingController();

//   TextEditingController text1 = TextEditingController();
//   TextEditingController text2 = TextEditingController();
//   TextEditingController text3 = TextEditingController();

//   QuerySnapshot<Map<String, dynamic>>? datum;

// Scaffold(
//       body: Center(
//           child: Column(
//         children: [
//           Text('CRUDView'),
//           ElevatedButton(
//               onPressed: () async {
//                 log('1');
//                 await context.read<UserState>().logout();
//                 log('2');
//                 MyNavigator.calculateNavigation();
//               },
//               child: Text("logout")),
//           TextField(
//             controller: text1,
//             textAlign: TextAlign.center,
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               // final result = await FirebaseFunctions.instance
//               //     .httpsCallable('makeadmin')
//               //     .call(<String, dynamic>{
//               //   'emailToElevate': text1.text,
//               // });

//               final result = await FirebaseFunctions.instance
//                   .httpsCallable('makeAdmin')
//                   .call(<String, dynamic>{
//                 'emailToElevate': text1.text,
//                 'role': 'super-admin',
//               });

//               log(result.data.toString());
//             },
//             child: Text("addAdmin"),
//           ),
//           IconButton(
//               onPressed: () {
//                 AlertDialog alert = AlertDialog(
//                   title: Text("Add Course"),
//                   content: ListView(
//                     children: [
//                       Form(
//                           key: _formKey,
//                           child: Column(
//                             children: [
//                               TextFormField(
//                                 controller: emailController,
//                                 validator: (value) {
//                                   if (_emailRegex.hasMatch(value!)) {
//                                     emailController.text = 'wrong format';
//                                   }
//                                 },
//                               )
//                             ],
//                           ))
//                     ],
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () {},
//                       child: Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         _formKey.currentState!.validate();
//                       },
//                       child: Text('Submit'),
//                     ),
//                   ],
//                 );

//                 // show the dialog
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return alert;
//                   },
//                 );
//               },
//               icon: Icon(Icons.add)),
//           ElevatedButton(
//             onPressed: () async {
//               final result = await FirebaseFunctions.instance
//                   .httpsCallable('getuid')
//                   .call();
//               log(result.data.toString());
//             },
//             child: Text("getuid"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               final result = await FirebaseFunctions.instance
//                   .httpsCallable('returnemail')
//                   .call();
//               log(result.data.toString());
//             },
//             child: Text("returnemail"),
//           ),
//           FutureBuilder(
//             future: context.watch<UserState>().currentUserClaims,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done &&
//                   snapshot.hasData) {
//                 return Text(
//                   'Role: ' + snapshot.data!['role'],
//                   style: TextStyle(fontSize: 32),
//                 );
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//           TextField(
//             controller: text2,
//             textAlign: TextAlign.center,
//           ),
//           TextField(
//             controller: text3,
//             textAlign: TextAlign.center,
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               final db = FirebaseFirestore.instance;
//               final data = <String, String>{
//                 "data1": text2.text,
//                 "data2": text3.text,
//               };

//               db
//                   .collection("cities")
//                   // .doc("LA")
//                   .add(data);
//             },
//             child: Text("test firestore test1"),
//           ),

//           //well teechnically works but it diappears instantly
//           ElevatedButton(
//             onPressed: () async {
//               print('udpate1');
//               final db = FirebaseFirestore.instance;
//               await db
//                   .collection('cities')
//                   .where('data1', isNull: false)
//                   .get()
//                   .then((querySnapshot) => datum = querySnapshot);
//               print('second');
//               print(datum!.docs.length);
//               print(datum == null ? 0 : datum!.docs.length);
//               setState(() {});
//             },
//             child: Text("update test1"),
//           ),
//           Container(
//             height: 200,
//             child: ListView.builder(
//               itemCount: datum == null ? 0 : datum!.docs.length,
//               itemBuilder: (context, index) {
//                 print(datum!.docs[index].data()['data1']);
//                 return Text(datum!.docs[index].data()['data1']);
//               },
//             ),
//           )
//         ],
//       )),
//     );