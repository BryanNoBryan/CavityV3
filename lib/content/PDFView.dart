import '../navigation/MyNavigator.dart';
import '../providers/UserDatabase.dart';
import '../providers/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PDFView extends StatefulWidget {
  const PDFView({super.key});

  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        centerTitle: true,
      ),
      body: Text('PDF'),
    );
  }
}
