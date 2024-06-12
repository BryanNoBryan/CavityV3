// ignore_for_file: file_names
import 'MyNavigator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, required this.child});

  final StatefulNavigationShell child;

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int idx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: idx,
        onTap: (index) {
          idx = index;
          switch (index) {
            case 0:
              MyNavigator.router.go(MyNavigator.AIViewPath);
              break;
            case 1:
              MyNavigator.router.go(MyNavigator.CRUDViewPath);
              break;
            case 2:
              MyNavigator.router.go(MyNavigator.PDFPath);
              break;
            case 3:
              MyNavigator.router.go(MyNavigator.profilePath);
              break;
          }
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.computer),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.picture_as_pdf),
            label: 'PDF',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
