import 'package:flutter/material.dart';
import 'package:notekeeperapp/view/home.dart';
import 'package:notekeeperapp/view/login_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Spl_Scn extends StatefulWidget {
  const Spl_Scn({super.key});

  @override
  State<Spl_Scn> createState() => _Spl_ScnState();
}

class _Spl_ScnState extends State<Spl_Scn> {
  late SharedPreferences sharedPreferences;
  bool k = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getper();
    Future.delayed(
      Duration(
        seconds: 7,
      ),
      () {
        k = sharedPreferences.getBool("isLogin") ?? false;
        (k == false)
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Sing_In(),
                ),
              )
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
      },
    );
  }

  getper() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            Container(
              height: 250,
              child: Image.asset("assets/images/notes.gif"),
            ),
            SizedBox(
              height: 150,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
