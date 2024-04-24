import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lunalifts/AllScreens/registrationScreen.dart';
import 'package:lunalifts/AllScreens/mainScreen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, required String title}) : super(key: key);
  static const String idScreen = "login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const Image(
                image: AssetImage("images/logo.png"),
                width: 200.0,
                height: 200.0,
                alignment: Alignment.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Let's Sign You In",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontFamily: "Brand-Bold"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 14.0),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(fontSize: 14.0),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  loginAndAuthenticateUser(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                child: const Text("Login"),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.idScreen);
                },
                child: const Text(
                  "Do not have an account? Register Here",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginAndAuthenticateUser(BuildContext context) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );
      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // Login successful, navigate to MainScreen
        print("User logged in!!");
        displayToastMessage("Login Succesful", context);
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
      } else {
        // Handle login failure
        print("Login failed");
        displayToastMessage("Login failed. Please check your credentials.", context);
      
      }
    } catch (e) {
      print("Error during user login: $e");
      // Handle other exceptions as needed
      displayToastMessage("Error during login. Please try again.", context);
    }
  }

  void displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
