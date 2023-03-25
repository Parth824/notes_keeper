import 'package:flutter/material.dart';
import 'package:notekeeperapp/hlper/dbhlper.dart';

class NotesPages extends StatefulWidget {
  const NotesPages({super.key});

  @override
  State<NotesPages> createState() => _NotesPagesState();
}

class _NotesPagesState extends State<NotesPages> {
  TextEditingController t = TextEditingController();
  TextEditingController b = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String? body;
  String? tital;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              if (_globalKey.currentState!.validate()) {
                _globalKey.currentState!.save();
                print("Parth");
                Map<String, dynamic> k = {
                  "title": tital,
                  "body": body,
                };
                await Dbhlper.dbhlper.insert(data: k);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Insert Data Succfuly...."),
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
                  controller: b,
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
                      controller: t,
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
