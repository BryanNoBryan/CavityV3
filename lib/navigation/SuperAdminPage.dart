// ignore_for_file: file_names
import '../MyColors.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Cavity'),
      //   surfaceTintColor: MyColors.lightYellow,
      //   actions: [
      //     IconTextButton(
      //       icon: Icon(Icons.book),
      //       onPressed: () {
      //         MyNavigator.router.go(MyNavigator.AIViewPath);
      //       },
      //       label: 'AI',
      //     ),
      //     IconTextButton(
      //       icon: Icon(Icons.favorite),
      //       onPressed: () {
      //         MyNavigator.router.go(MyNavigator.CRUDViewPath);
      //       },
      //       label: 'Edit',
      //     ),
      //     IconTextButton(
      //       icon: Icon(Icons.badge),
      //       onPressed: () {
      //         MyNavigator.router.go(MyNavigator.PDFPath);
      //       },
      //       label: 'PDF',
      //     ),
      //     IconTextButton(
      //       icon: Icon(Icons.account_circle_outlined),
      //       onPressed: () {
      //         MyNavigator.router.go(MyNavigator.profilePath);
      //       },
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
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
