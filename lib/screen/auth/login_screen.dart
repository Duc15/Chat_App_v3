import 'dart:developer';
import 'dart:io';

import 'package:chat_app_v3/helper/dialogs.dart';
import 'package:chat_app_v3/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../api/apis.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 500), () {
      _isAnimate = true;
    });
  }

  _handleGoogleBtnClick() {
    Dialogs.showProgessBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditional: ${user.additionalUserInfo}');
        if ((await APIs.userExists())) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else {
          await APIs.createUser().then((value) => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeScreen())));
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'Something went wrong');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Wellcome to Hà Nội Bay',
        ),
      ),
      body: Stack(children: [
        AnimatedPositioned(
          right: _isAnimate ? mq.width * .25 : -mq.width * .5,
          width: mq.width * .5,
          top: mq.height * .15,
          duration: const Duration(seconds: 1),
          child: Image.asset('assets/images/chatlogo.png'),
        ),
        Positioned(
          bottom: mq.height * .15,
          left: mq.width * .05,
          width: mq.width * .9,
          height: mq.height * .06,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 126, 235, 130),
                shape: const StadiumBorder()), //bo tron khung
            onPressed: () {
              _handleGoogleBtnClick();
            },
            icon: Image.asset(
              'assets/images/google.png',
              height: mq.height * .03,
            ),
            label: RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 19),
                children: [
                  TextSpan(text: 'Log in with'),
                  TextSpan(
                    text: 'Google',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
