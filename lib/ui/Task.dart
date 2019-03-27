import 'package:flutter/material.dart';
import 'Complete.dart';
import 'NewSubject.dart';

class Task extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TaskState();
  }
}

class TaskState extends State<Task> {
  int count = 0;
  int _currentIndex = 0;
  final List<Widget> _childern = [
    CompleteWidget(Colors.red),
    CompleteWidget(Colors.black)
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //push to task page
              debugPrint('Add button');
              navigateToNewSub();
            },
          )
        ],
      ),

      //body
      //getTaskListView()
      body: _childern[_currentIndex],

      //bottomNav
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            title: new Text('Task')
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.done_all),
            title: new Text('Complete')
          )
        ],
      ),
    );
  }

  ListView getTaskListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text('Dummy Title', style: titleStyle),
              subtitle: Text('Dummy Date'),
              onTap: () {
                debugPrint('List Title Tap');
                navigateToNewSub();
              },
            ),
          );
        });
  }

  void navigateToNewSub(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return NewSubject();
    }));
  }

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index; 
    });
  }
}
