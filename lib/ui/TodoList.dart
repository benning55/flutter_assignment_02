import 'package:flutter/material.dart';
import './NewSubject.dart';
import '../models/Note.dart';
import '../utils/DatabaseManage.dart';

class TodoList extends StatefulWidget {
  @override
  TodoListWidgetState createState() => new TodoListWidgetState();
}

class TodoListWidgetState extends State<TodoList> {
  List<Note> items = new List(); // List to Show a data
  DatabaseManage db = new DatabaseManage();

  int count = 0;

  @override
  void initState() {
    super.initState();

    db.getAllNote().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (items.length == 0) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Todo"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _navigateToNewSub(context),
            )
          ],
        ),
        body: Center(
          child: new Text(
            "No data found..",
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Todo"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //push to task page
                debugPrint('Add button');
                _navigateToNewSub(context);
              },
            )
          ],
        ),
        body: Center(
          child: getTaskListView(),
        ),
      );
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
                value: i['done'] == 1 ? false : true,
                onChanged: (bool value) {
                  setState(() {
                    db.updateNote(Note.fromMap(
                        {'id': i['id'], 'title': i['title'], 'done': true}));
                    db.getAllNote().then((notes) {
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

  void _navigateToNewSub(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewSubject(Note.getValue(''))),
    );

    db.getAllNote().then((notes) {
      setState(() {
        items.clear();
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }
}
