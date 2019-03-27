import 'package:flutter/material.dart';

class NewSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewSubjectState();
  }
}

class NewSubjectState extends State<NewSubject> {
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();     
    final _inputController = TextEditingController();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Subject'),
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
                  validator: (value){
                    if (value.isEmpty){
                      return 'Please fill subject';
                    }
                  },
                ),

                RaisedButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      Scaffold
                        .of(context)
                        .showSnackBar(SnackBar(content: Text("Processing Data")));
                    }
                  },
                  child: Text("Save"),
                )
              ],
            )
        ),
      ),

    );
  }
}
