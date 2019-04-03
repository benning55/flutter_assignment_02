final String noteTable = 'note_table';
final String colId = 'id';
final String colTitle = 'title';
final String colFinish = 'finish';

class Note {
  int _id;
  String _title;
  int _finish;

  int get id => _id;
  String get title => _title;
  int get finish => _finish;

  Note();

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._finish = map['finish'] == false ? 0 : 1;
  }

  Note.getValue(title) {
    this._title = title;
    this._finish = 0;
  }

  Note.map(dynamic object) {
    this._id = object['id'];
    this._title = object['title'];
    this._finish = object['finish'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {colTitle: _title, colFinish: _finish};
    if (_id != null) {
      map[colId] = _id;
    }
    return map;
  }
}
