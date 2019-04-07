import 'package:flutter/material.dart';
import "./../models/Note.dart";
import '../utils/DatabaseManage.dart';
import '../models/Note.dart';

class Complete extends StatefulWidget {
  @override
  CompleteWidgetState createState() => new CompleteWidgetState();
}

class CompleteWidgetState extends State<Complete> {
  List<Note> items = new List();
  DatabaseManage db = new DatabaseManage();

  @override
  void initState() {
    super.initState();
    db.getAllFinish().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (items.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Todo"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteAllNote(context);
              },
            )
          ],
        ),
        body: Center(
          child: Text("No data found..", textAlign: TextAlign.center),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Todo"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteAllNote(context);
                },
              )
            ],
          ),
          body: Center(
            child: getTaskListView(),
          ));
    }
  }

  ListView getTaskListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int position) {
          Map i = items[position].toMap();
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(i['title'], style: titleStyle),
              trailing: Checkbox(
                value: i['done'] == 0 ? false : true,
                onChanged: (bool value) {
                  setState(() {
                    db.updateNote(Note.fromMap(
                        {'id': i['id'], 'title': i['title'], 'done': false}));
                    db.getAllFinish().then((notes) {
                      setState(() {
                        items.clear();
                        notes.forEach((note) {
                          items.add(Note.fromMap(note));
                        });
                      });
                    });
                  });
                },
              ),
            ),
          );
        });
  }

  void _deleteAllNote(BuildContext context) async {
    db.deleteAllDone();
    db.getAllFinish().then((notes) {
      setState(() {
        items.clear();
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }
}
