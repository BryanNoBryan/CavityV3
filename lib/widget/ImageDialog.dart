import 'dart:io';

import 'package:cavity3/navigation/MyNavigator.dart';

import '../providers/model_classes/MyRecord.dart';
import '../providers/database.dart';
import 'package:flutter/material.dart';

import '../classifier/photo_view.dart';

class ImageDialog extends StatefulWidget {
  const ImageDialog(
      {required this.path,
      required this.disease,
      required this.accuracy,
      required this.onaccept,
      super.key});

  final File path;
  final String disease;
  final double accuracy;
  final Function() onaccept;

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  final primaryColor2 = Color(0xff4338CA);
  final secondaryColor2 = Color(0xff6D28D9);
  final accentColor2 = Color(0xffffffff);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // name.text = !widget.isCreate ? widget.course!.timestamp ?? '' : '';
    // desc.text = !widget.isCreate ? widget.course!.disease ?? '' : '';
    // code.text = !widget.isCreate ? widget.course!.code ?? '' : '';
    // subject.text = !widget.isCreate ? widget.course!.subject ?? '' : '';
    // timeDesc.text = !widget.isCreate ? widget.course!.timeDesc ?? '' : '';
    // level.text = !widget.isCreate ? widget.course!.level ?? '' : '';
    // prereq.text = !widget.isCreate ? widget.course!.prereq ?? '' : '';
    // tags.text = !widget.isCreate
    //     ? widget.course!.tags?.reduce((v, e) => v = '$v,$e') ?? ''
    //     : '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 350,
        height: MediaQuery.of(context).size.height / 1.6,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  "Accept/Reject",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              PhotoView(file: widget.path),
              const SizedBox(
                height: 3.5,
              ),
              Center(
                child: Text(
                  "Disease ${widget.disease} with accuracy ${double.parse(widget.accuracy.round().toStringAsFixed(4)) * 100}%",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 3.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SimpleBtn1(
                      text: "Accept",
                      onPressed: () async {
                        await widget.onaccept();
                        MyNavigator.router.pop();
                      }),
                  SimpleBtn1(
                    text: "Reject",
                    onPressed: () {
                      MyNavigator.router.pop();
                    },
                    invertedColors: true,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  const Input(
      {required this.title,
      this.hint = '',
      super.key,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white.withOpacity(.9)),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1)),
          ]),
          child: TextField(
            controller: controller,
            onChanged: (value) {
              //Do something with
            },
            style: const TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              label: Text(title),
              labelStyle: const TextStyle(color: primaryColor),
              // prefixIcon: Icon(Icons.email),
              filled: true,
              fillColor: accentColor,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  const SimpleBtn1(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      super.key});
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            alignment: Alignment.center,
            side: MaterialStateProperty.all(
                BorderSide(width: 1, color: primaryColor)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.only(right: 15, left: 15, top: 0, bottom: 0)),
            backgroundColor: MaterialStateProperty.all(
                invertedColors ? accentColor : primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: invertedColors ? primaryColor : accentColor, fontSize: 16),
        ));
  }
}
