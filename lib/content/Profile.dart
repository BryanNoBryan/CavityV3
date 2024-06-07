import 'package:bottom_picker/bottom_picker.dart';
import 'package:intl/intl.dart';

import '../MyColors.dart';
import '../navigation/MyNavigator.dart';
import '../providers/UserDatabase.dart';
import '../providers/database.dart';
import '../providers/model_classes/MyUser.dart';
import '../providers/user_state.dart';
import 'package:flutter/material.dart';

import '../widget/InputHelper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  String DOBText = '';
  DateTime? DOB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MyUser? user = UserDatabase().getUser();

    firstName.text = user?.firstName ?? '';
    lastName.text = user?.lastName ?? '';
    DOB = user?.DOB;
    DOBText = DOB != null ? DateFormat.yMd().format(DOB!) : 'Choose DOB';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
          backgroundColor: MyColors.green,
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Information',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    InputHelper(
                      name: 'firstName',
                      controller: firstName,
                    ),
                    InputHelper(
                      name: 'lastName',
                      controller: lastName,
                    ),

                    //DT
                    GestureDetector(
                        behavior: HitTestBehavior.deferToChild,
                        onTap: () {
                          BottomPicker.date(
                            pickerTitle: Text(
                              'Set your Birthday',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            ),
                            initialDateTime: DOB ?? DateTime.now(),
                            maxDateTime: DateTime.now(),
                            minDateTime: DateTime.now()
                                .subtract(const Duration(days: 365 * 200)),
                            pickerTextStyle: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            onSubmit: (index) {
                              DOB = index;
                              DOBText = DateFormat.yMd().format(index);
                              setState(() {});
                            },
                          ).show(context);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          decoration: BoxDecoration(
                              color: MyColors.lightBlue,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.blueAccent)),
                          child: Text(
                            DOBText,
                            style: TextStyle(fontSize: 16),
                          ),
                        )),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          MyUser myUser = MyUser(
                              firstName: firstName.text,
                              lastName: lastName.text,
                              DOB: DOB);
                          await UserDatabase().updateUser(myUser);
                        },
                        child: Text(
                          'Update Profile',
                          style: TextStyle(fontSize: 32),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          UserState().logout();
                          MyNavigator.shell.goBranch(0);
                          print('outout');
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(fontSize: 32),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
