// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lunalifts/AllScreens/loginScreen.dart';
import 'package:lunalifts/AllScreens/mainScreen.dart';
import 'package:lunalifts/main.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key, required String title}) : super(key: key);

  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
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
              SizedBox(height: 10),
              Image(
                image: AssetImage("images/logo.png"),
                width: 200.0,
                height: 200.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 10),
              Text(
                "Sign Up As Passenger",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontFamily: "Brand-Bold"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameTextEditingController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  labelStyle: TextStyle(fontSize: 14.0),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: TextStyle(fontSize: 14.0),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 10),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if(nameTextEditingController.text.length < 4){
                    displayToastMessage("Name Must Be At Least 3 Letters", context);
                  }
                  else if(!emailTextEditingController.text.contains("@")){
                    displayToastMessage("Email address is not valid", context);
                  }
                  else if(passwordTextEditingController.text.length < 7 ){
                    displayToastMessage("Password should not be less than 7 characters", context);
                  }
                  else{
                      registerNewUser(context);
                  }
                  
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color
                ),
                child: Text("Register"),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Already have an account? Login",
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

 void registerNewUser(BuildContext context) async {
  try {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: emailTextEditingController.text,
      password: passwordTextEditingController.text,
    );
    User? firebaseUser = userCredential.user;
    if (firebaseUser != null) {
      // Registration successful, proceed to MainScreen
      print("User created!!");
      
      // Save user data to Firebase Realtime Database
      Map<String, dynamic> userDataMap = {
        "name": nameTextEditingController.text,
        "email": emailTextEditingController.text,
        "phone": phoneTextEditingController.text,
      };
      userRef.child(firebaseUser.uid).set(userDataMap);

      // Display success message
      displayToastMessage("Account Created Successfully", context);

      // Navigate to MainScreen and remove all previous routes from stack
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    } else {
      // Handle registration failure
      print("User registration failed");
      displayToastMessage("User registration failed. Please try again.", context);
    }
  } catch (e) {
    print("Error during user registration: $e");
    // Handle other exceptions as needed
    displayToastMessage("Error during registration. Please try again.", context);
  }
}


  
}

displayToastMessage(String message, BuildContext context){
  Fluttertoast.showToast(msg: message);
}
