import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../models/Note.dart';
import '../utils/DatabaseManage.dart';

class NewSubject extends StatefulWidget {
  final Note note;

  NewSubject(this.note);
  @override
  State<StatefulWidget> createState() {
    return NewSubjectState();
  }
}

class NewSubjectState extends State<NewSubject> {
  DatabaseManage db = new DatabaseManage();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = new TextEditingController(text: widget.note.title);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Subject'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            moveToLastScreen();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: _inputController,
                  decoration: InputDecoration(
                    labelText: "Subject",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill subject';
                    }
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      debugPrint("already validate");
                      debugPrint(_inputController.text);
                      db
                          .saveNewNote(Note.getValue(_inputController.text))
                          .then((_) {
                        moveToLastScreen();
                      });
                    }
                  },
                  child: Text("Save"),
                )
              ],
            )),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
