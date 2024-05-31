// ignore_for_file: file_names

import 'dart:developer';

import '../content/AIView.dart';

import '../content/CRUDView.dart';
import '../content/AIView.dart';
import '../content/PDFView.dart';
import '../content/Profile.dart';
import '../login/VerifyEmail.dart';
import '../login/WelcomeLogin.dart';
import '../content/placeholder.dart';
import '../navigation/PlaceholderPage.dart';
import '../navigation/SuperAdminPage.dart';
import '../providers/UserDatabase.dart';
import '../providers/user_state.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'LoginPage.dart';

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
                    path: loginPath,
                    pageBuilder: (context, GoRouterState state) {
                      return getPage(
                        child: const AuthGate(),
                        state: state,
                      );
                    }),
                GoRoute(
                    path: forgotPasswordPath,
                    pageBuilder: (context, GoRouterState state) {
                      final arguments = state.uri.queryParameters;
                      return getPage(
                        child: ForgotPasswordScreen(
                          email: arguments['email'],
                          headerMaxExtent: 200,
                        ),
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
                GoRoute(
                    path: defaultPath,
                    pageBuilder: (context, GoRouterState state) {
                      return getPage(
                        child: const AIView(),
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
            child: NavBarPage(child: navigationShell)
            // (shell.currentIndex == 0)
            //     ? NavigationLoginPage(child: navigationShell)
            //     : SuperAdminPage(child: navigationShell)
            ,
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
    log('calualting');
    UserState state = UserState();
    bool loggedIn = state.loggedIn;
    bool verified = state.verified;
    log(loggedIn.toString());
    log(verified.toString());
    if (loggedIn) {
      if (!verified) {
      } else {
        var claims = await state.currentUserClaims;
        String? role = claims?['role'];
        await UserDatabase().retrieveUser();
        if (role == null || role == UserState.REGULAR) {
          log('NULL OR REGULAR');
          MyNavigator.shell.goBranch(1);
          MyNavigator.router.go(MyNavigator.AIViewPath);
        } else if (role == UserState.ADMIN || role == UserState.SUPERADMIN) {
          log('ADMIN OR SUPER ADMIN');
          MyNavigator.shell.goBranch(1);
          MyNavigator.router.go(MyNavigator.CRUDViewPath);
        }
      }
    }
  }
}

// import 'dart:developer';

// import '../content/CRUDView.dart';
// import '../content/CourseView.dart';
// import '../login/VerifyEmail.dart';
// import '../login/WelcomeLogin.dart';
// import '../content/placeholder.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import 'NavigationLoginPage.dart';

// class MyNavigator {
//   static final MyNavigator _instance = MyNavigator._internal();

//   static MyNavigator get instance => _instance;
//   factory MyNavigator() {
//     return _instance;
//   }

//   static late StatefulNavigationShell _navigationShell;
//   static StatefulNavigationShell get shell => _navigationShell;

//   static late final GoRouter router;

//   static late int _navigationbarIndex;
//   static int get navigationbarIndex => _navigationbarIndex;

//   static final GlobalKey<NavigatorState> parentNavigatorKey =
//       GlobalKey<NavigatorState>();

//   //

//   static final GlobalKey<NavigatorState> loginNavigatorKey =
//       GlobalKey<NavigatorState>();

//   static final GlobalKey<NavigatorState> courseViewKey =
//       GlobalKey<NavigatorState>();

//   static final GlobalKey<NavigatorState> CRUDViewKeySuperAdmin =
//       GlobalKey<NavigatorState>();

//   static final GlobalKey<NavigatorState> CRUDViewKeyAdmin =
//       GlobalKey<NavigatorState>();

//   static final GlobalKey<NavigatorState> permissionsViewKey =
//       GlobalKey<NavigatorState>();

//   static final GlobalKey<NavigatorState> profileKey =
//       GlobalKey<NavigatorState>();

//   static const String defaultPath = '/';
//   static const String loginPath = '/login';
//   static const String verifyEmailPath = '/login/verify-email';
//   static const String forgotPasswordPath = '/login/forgot-password';

//   //NEW TO IMPLEMENT
//   static const String courseViewPath = '/course-view';
//   static const String CRUDViewPath = '/crud-view';
//   static const String permissionsViewPath = '/permissions-view';
//   static const String profilePath = '/profile';

//   MyNavigator._internal() {
//     final routes = [
//       StatefulShellRoute.indexedStack(
//         parentNavigatorKey: parentNavigatorKey,
//         branches: [
//           //LOGIN
//           StatefulShellBranch(
//               navigatorKey: loginNavigatorKey,
//               initialLocation: loginPath,
//               routes: [
//                 GoRoute(
//                     path: defaultPath,
//                     pageBuilder: (context, GoRouterState state) {
//                       return getPage(
//                         child: const AuthGate(),
//                         state: state,
//                       );
//                     }),
//                 GoRoute(
//                     path: loginPath,
//                     pageBuilder: (context, GoRouterState state) {
//                       return getPage(
//                         child: const AuthGate(),
//                         state: state,
//                       );
//                     }),
//                 GoRoute(
//                     path: forgotPasswordPath,
//                     pageBuilder: (context, GoRouterState state) {
//                       final arguments = state.uri.queryParameters;
//                       return getPage(
//                         child: ForgotPasswordScreen(
//                           email: arguments['email'],
//                           headerMaxExtent: 200,
//                         ),
//                         state: state,
//                       );
//                     }),
//                 GoRoute(
//                     path: verifyEmailPath,
//                     pageBuilder: (context, GoRouterState state) {
//                       return getPage(
//                         child: const VerifyEmail(),
//                         state: state,
//                       );
//                     }),
//               ]),
//           //SUPER ADMIN
//           StatefulShellBranch(
//               navigatorKey: CRUDViewKeySuperAdmin,
//               initialLocation: CRUDViewPath,
//               routes: [
//                 GoRoute(
//                   path: CRUDViewPath,
//                   pageBuilder: (context, GoRouterState state) {
//                     return getPage(
//                       child: const CRUDView(),
//                       state: state,
//                     );
//                   },
//                 ),
//               ]),
//           //ADMIN
//           StatefulShellBranch(
//               navigatorKey: CRUDViewKeyAdmin,
//               initialLocation: CRUDViewPath,
//               routes: [
//                 GoRoute(
//                   path: CRUDViewPath,
//                   pageBuilder: (context, GoRouterState state) {
//                     return getPage(
//                       child: const CRUDView(),
//                       state: state,
//                     );
//                   },
//                 ),
//               ]),
//           //REGULAR USER
//           StatefulShellBranch(
//               navigatorKey: courseViewKey,
//               initialLocation: courseViewPath,
//               routes: [
//                 GoRoute(
//                   path: courseViewPath,
//                   pageBuilder: (context, GoRouterState state) {
//                     return getPage(
//                       child: const CourseView(),
//                       state: state,
//                     );
//                   },
//                 ),
//               ]),
//         ],
//         pageBuilder: (
//           BuildContext context,
//           GoRouterState state,
//           StatefulNavigationShell navigationShell,
//         ) {
//           _navigationShell = navigationShell;
//           return getPage(
//             child: NavigationLoginPage(child: navigationShell),
//             state: state,
//           );
//         },
//       )
//     ];
//     router = GoRouter(
//       navigatorKey: parentNavigatorKey,
//       initialLocation: loginPath,
//       routes: routes,
//     );
//   }

//   static Page getPage({
//     required Widget child,
//     required GoRouterState state,
//   }) {
//     log(shell.currentIndex.toString());
//     log(router.routeInformationProvider.toString());
//     return MaterialPage(
//       key: state.pageKey,
//       child: child,
//     );
//   }
// }
