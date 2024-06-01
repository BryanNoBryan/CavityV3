import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../navigation/MyNavigator.dart';
import '../providers/user_state.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (UserState.user != null) {
        if (UserState.user!.emailVerified) {
          log('calced nav in login');
          MyNavigator.calculateNavigation();
        }
        MyNavigator.router.pushReplacement(MyNavigator.verifyEmailPath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log('auth gate built');
    log('user is null' +
        (FirebaseAuth.instance.currentUser == null).toString());

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print('passed pre');
        if (!snapshot.hasData) {
          print('has data');
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            actions: [
              ForgotPasswordAction(((context, email) {
                final uri = Uri(
                  path: MyNavigator.forgotPasswordPath,
                  queryParameters: <String, String?>{
                    'email': email,
                  },
                );
                context.push(uri.toString());
              })),
              AuthStateChangeAction(((context, state) {
                dynamic user;
                print('passed here');
                if (state is SignedIn) {
                  user = state.user;
                } else if (state is UserCreated) {
                  user = state.credential.user;
                }
                print('passed here 2');
                if (user == null) {
                  return;
                }
                if (state is UserCreated) {
                  user.updateDisplayName(user.email!.split('@')[0]);
                }
                if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
                  log('calced nav in login v2');
                  MyNavigator.calculateNavigation();
                } else {
                  MyNavigator.router
                      .pushReplacement(MyNavigator.verifyEmailPath);
                }
              })),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: AspectRatio(
                  aspectRatio: 1.647,
                  child: Image.asset('assets/images/icon.png'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text(
                        'Welcome to BxSci Course Guide, please sign in!')
                    : const Text(
                        'Welcome to BxSci Course Guide, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1.647,
                  child: Image.asset('images/icon.png'),
                ),
              );
            },
          );
        }

        return const Placeholder();
      },
    );
  }
}
