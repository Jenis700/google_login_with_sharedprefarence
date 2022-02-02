// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_login_sharedprefarence/sign_in_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? email;
  String? id;
  String? name;
  String? photo;
  String? code;
  @override
  void initState() {
    super.initState();
    gateValue();
  }

  gateValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString("email");
      id = prefs.getString("id");
      name = prefs.getString("name");
      photo = prefs.getString("photo");
      code = prefs.getString("code");
    });
  }

  Future singout() async {
    final GoogleSignIn gOut = GoogleSignIn();
    final GoogleSignInAccount? gAccount = await gOut.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.deepOrange,
              backgroundImage: NetworkImage(
                Uri.parse(photo!).toString(),
              ),
            ),
            const SizedBox(height: 25),
            ShaderMask(
              shaderCallback: (jenis) => const LinearGradient(
                colors: [
                  Colors.yellow,
                  Colors.red,
                ],
                tileMode: TileMode.mirror,
              ).createShader(jenis),
              child: Text(
                "$name",
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            ShaderMask(
              shaderCallback: (jenis) => const RadialGradient(
                colors: [
                  Colors.red,
                  Colors.black,
                ],
                stops: [0.0, 0.5],
                tileMode: TileMode.mirror,
              ).createShader(jenis),
              child: Text(
                "$email",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                singout();
              },
              child: const Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }
}
