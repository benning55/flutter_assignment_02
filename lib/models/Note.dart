final String todoTable = 'todo';
final String colId = 'id';
final String colTitle = 'title';
final String colDone = 'done';

class Note {
  int _id;
  String _title;
  int _done;

  int get id {
    return _id;
  }

  String get title {
    return _title;
  }

  int get finish {
    return _done;
  }

  Note();

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    if (map['done'] == false) {
      this._done = 0;
    } else {
      this._done = 1;
    }
  }

  Note.getValue(title) {
    this._title = title;
    this._done = 0;
  }

  Note.map(dynamic object) {
    this._id = object['id'];
    this._title = object['title'];
    this._done = object['done'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {colTitle: _title, colDone: _done};
    if (_id != null) {
      map[colId] = _id;
    }
    return map;
  }
}
