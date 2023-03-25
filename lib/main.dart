import 'package:flutter/material.dart';
import 'package:notekeeperapp/view/Sing_up.dart';
import 'package:notekeeperapp/view/home.dart';
import 'package:notekeeperapp/view/login_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notekeeperapp/view/notes_pages.dart';
import 'package:notekeeperapp/view/sples_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute:"/",
      routes: {
        "Home": (context) => HomePage(),
        "/": (context) => Spl_Scn(),
        "login": (context) => Sing_In(),
        "SingUp": (context) => Login_Up(),
        "note":(context) => NotesPages(),
      },
    ),
  );
}
