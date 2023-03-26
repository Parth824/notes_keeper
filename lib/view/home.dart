import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notekeeperapp/hlper/dbhlper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      body: StreamBuilder(
        stream: Dbhlper.db.collection("note").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> k = data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: MasonryGridView.builder(
                itemCount: k.length,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Map<String, dynamic> l = k[index].data();
                      l.addAll({'id': k[index].id});
                      print(l);
                      Navigator.of(context).pushNamed("note1", arguments: l);
                    },
                    child: Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        child: Center(
                          child: Text(
                            "Delete",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        color: Colors.red,
                      ),
                      onDismissed: (direction) async {
                        await Dbhlper.dbhlper.Delete(id: k[index].id);
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff0f0f0),
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0.5, 0.5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${k[index]['title']}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("${k[index]['body']}")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
