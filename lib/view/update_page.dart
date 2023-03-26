import 'package:flutter/material.dart';
import 'package:notekeeperapp/hlper/dbhlper.dart';

class NotesPages1 extends StatefulWidget {
  const NotesPages1({super.key});

  @override
  State<NotesPages1> createState() => _NotesPages1State();
}

class _NotesPages1State extends State<NotesPages1> {
  TextEditingController t = TextEditingController();
  TextEditingController b = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String? body;
  String? tital;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    t.text = data['title'];
    b.text = data['body'];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              if (_globalKey.currentState!.validate()) {
                _globalKey.currentState!.save();
                Map<String, dynamic> k = {
                  "title": tital,
                  "body": body,
                };
                await Dbhlper.dbhlper.update(id: data['id'], k: k);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Update Data Succfuly...."),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                  ),
                );
                setState(() {
                  b.clear();
                  t.clear();
                  body = "";
                  tital = "";
                });
              } else {}
            },
            icon: Icon(
              Icons.save,
              size: 30,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: t,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  onSaved: (val) {
                    setState(() {
                      tital = val;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter the titel...";
                    }
                    return null;
                  },
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(fontSize: 22),
                    border: InputBorder.none,
                  ),
                ),
                Text(
                  "Sun,${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} | ${DateTime.now().hour}:${DateTime.now().minute}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 0.5)
                      ],
                    ),
                    child: TextFormField(
                      maxLines: 50,
                      controller: b,
                      onSaved: (val) {
                        setState(() {
                          body = val;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter the Body...";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Body",
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
