import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_note_php_mysql/models/note_model.dart';
import 'package:photo_note_php_mysql/services/dbService.dart';

class UpdateViewModel extends ChangeNotifier {
  final DbService _service = DbService();

  Future<Response> updateNote(String? id, String? name, String? descr) async {
    NoteModel note = NoteModel(id: id, noteName: name, noteDescr: descr);
    Response response = await _service.updateNote(note.toMap());
    return response;
  }
}
