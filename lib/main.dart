import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lunalifts/AllScreens/loginScreen.dart';
import 'package:lunalifts/AllScreens/mainScreen.dart';
import 'package:lunalifts/AllScreens/registrationScreen.dart';
import 'package:lunalifts/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LunaLifts',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: LoginScreen.idScreen,
      routes:
      {
        RegistrationScreen.idScreen: (context)=>  RegistrationScreen(title: 'Registration',),
        LoginScreen.idScreen: (context)=> LoginScreen(title: 'Login',),
        MainScreen.idScreen: (context)=>  MainScreen(title: 'MainScreen',),
        },
        debugShowCheckedModeBanner: false,
    );
  }
}


  