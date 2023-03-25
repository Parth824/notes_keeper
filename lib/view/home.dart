import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../hlper/firbase_hlper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    getper();
  }

  getper() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await Firbase_Hlper.fireHleper.Logout();
              await sharedPreferences.setBool("isLogin", false);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            child: Icon(
              Icons.power_settings_new,
              size: 30,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("note");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
