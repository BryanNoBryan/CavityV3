import 'package:flutter/material.dart';

import '../MyColors.dart';

class InputHelper extends StatelessWidget {
  const InputHelper(
      {required this.name,
      required this.controller,
      this.editable = true,
      super.key});
  final String name;
  final TextEditingController controller;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.lightBlue,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blueAccent)),
      child: TextField(
        enabled: editable,
        readOnly: !editable,
        controller: controller,
        decoration: InputDecoration(
          label: Text(
            name,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
