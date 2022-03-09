class NoteModel {
  final String? userId;
  final String? noteName;
  final String? noteDescr;
  final String? url;
  final String? id;

  NoteModel({this.userId, this.noteName, this.noteDescr, this.url, this.id});

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "note_name": noteName,
        "note_descr": noteDescr,
        "url": url,
        "id":id
      };

  factory NoteModel.fromMap(Map map) => NoteModel(
        userId: map["user_id"],
        noteName: map["note_name"],
        noteDescr: map["note_descr"],
        url: map["url"],
        id: map["id"],
      );
}
