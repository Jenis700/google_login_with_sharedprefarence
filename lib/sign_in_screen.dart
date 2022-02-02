// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  Future<void> singin(BuildContext context) async {
    final GoogleSignIn gSing = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await gSing.signIn();

    if (googleSignInAccount != null) {
      print("Email ::::::::::::::::: ${googleSignInAccount.email}");
      print("Name :::::::::::::::::: ${googleSignInAccount.displayName}");
      print("Id :::::::::::::::::::: ${googleSignInAccount.id}");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email", googleSignInAccount.email);
      prefs.setString("name", googleSignInAccount.displayName!);
      prefs.setString("id", googleSignInAccount.id);
      prefs.setString(
        "id",
        googleSignInAccount.serverAuthCode == null
            ? " Null"
            : googleSignInAccount.serverAuthCode!,
      );
      prefs.setString(
        "photo",
        googleSignInAccount.photoUrl == null
            ? "https://kgo.googleusercontent.com/profile_vrt_raw_bytes_1587515358_10512.png"
            : googleSignInAccount.photoUrl!,
      );
      print("Photo ::::::::::::::::: ${googleSignInAccount.photoUrl}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to google Sign In"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                singin(context);
              },
              child: const Text("Log In With Google"),
            ),
          ],
        ),
      ),
    );
  }
}
