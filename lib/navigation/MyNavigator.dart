// ignore_for_file: file_names

import 'dart:developer';

import 'package:cavity3/login/LoginPage.dart';

import '../content/AIView.dart';

import '../content/CRUDView.dart';
import '../content/AIView.dart';
import '../content/PDFView.dart';
import '../content/Profile.dart';
import '../login/VerifyEmail.dart';
import '../content/placeholder.dart';
import '../navigation/PlaceholderPage.dart';
import '../providers/database.dart';
import 'NavBarPage.dart';
import '../providers/UserDatabase.dart';
import '../providers/user_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'NavLoginPage.dart';

class MyNavigator {
  static final MyNavigator _instance = MyNavigator._internal();

  static MyNavigator get instance => _instance;
  factory MyNavigator() {
    return _instance;
  }

  static late StatefulNavigationShell _navigationShell;
  static StatefulNavigationShell get shell => _navigationShell;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();

  //
  static final GlobalKey<NavigatorState> checkLoginKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> loginNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> contentKey =
      GlobalKey<NavigatorState>();

  static const String defaultPath = '/';
  static const String loginPath = '/login';
  static const String verifyEmailPath = '/login/verify-email';
  static const String forgotPasswordPath = '/login/forgot-password';

  static const String AIViewPath = '/AI';
  static const String CRUDViewPath = '/crud';
  static const String PDFPath = '/pdf';
  static const String profilePath = '/profile';

  MyNavigator._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          //login and default check
          StatefulShellBranch(
              navigatorKey: loginNavigatorKey,
              initialLocation: loginPath,
              routes: [
                GoRoute(
                    path: defaultPath,
                    pageBuilder: (context, GoRouterState state) {
                      return getPage(
                        child: const LoginPage(),
                        state: state,
                      );
                    }),
                GoRoute(
                    path: loginPath,
                    pageBuilder: (context, GoRouterState state) {
                      return getPage(
                        child: const LoginPage(),
                        state: state,
                      );
                    }),
                GoRoute(
                    path: verifyEmailPath,
                    pageBuilder: (context, GoRouterState state) {
                      return getPage(
                        child: const VerifyEmail(),
                        state: state,
                      );
                    }),
              ]),
          //content
          StatefulShellBranch(
              navigatorKey: contentKey,
              initialLocation: CRUDViewPath,
              routes: [
                GoRoute(
                    path: AIViewPath,
                    pageBuilder: (context, GoRouterState state) {
                      return getPage(
                        child: const AIView(),
                        state: state,
                      );
                    }),
                GoRoute(
                  path: CRUDViewPath,
                  pageBuilder: (context, GoRouterState state) {
                    return getPage(
                      child: const CRUDView(),
                      state: state,
                    );
                  },
                ),
                GoRoute(
                    path: PDFPath,
                    pageBuilder: (context, GoRouterState state) {
                      return getPage(
                        child: const PDFView(),
                        state: state,
                      );
                    }),
                GoRoute(
                    path: profilePath,
                    pageBuilder: (context, GoRouterState state) {
                      return getPage(
                        child: const Profile(),
                        state: state,
                      );
                    }),
              ]),
        ],
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          _navigationShell = navigationShell;
          return getPage(
            child: (shell.currentIndex == 0)
                ? NavigationLoginPage(child: navigationShell)
                : NavBarPage(child: navigationShell),
            state: state,
          );
        },
      )
    ];
    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: defaultPath,
      routes: routes,
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

  static Future<void> calculateNavigation() async {
    log('nav calculation');
    await Database().initRecords();
    await UserDatabase().initUser();
    UserState state = UserState();
    bool loggedIn = state.loggedIn;
    bool verified = state.verified;
    log('logged in $loggedIn');
    log('verified $verified');
    if (loggedIn) {
      if (!verified) {
        log('part 1');
        MyNavigator.router.go(MyNavigator.verifyEmailPath);
      } else {
        log('part 2');
        MyNavigator.shell.goBranch(1);
        MyNavigator.router.go(MyNavigator.AIViewPath);
        log('part 3');
      }
    } else {
      MyNavigator.shell.goBranch(0);
      MyNavigator.router.go(MyNavigator.loginPath);
    }
  }
}
