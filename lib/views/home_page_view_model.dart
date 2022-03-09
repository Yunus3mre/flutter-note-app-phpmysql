import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:photo_note_php_mysql/models/note_model.dart';
import 'package:photo_note_php_mysql/services/dbService.dart';
import 'package:provider/provider.dart';

class HomePageViewModel extends ChangeNotifier {
  DbService _service = DbService();

  getData({String? userId}) async {
    
    
    List dataList = await _service.getData({"user_id": userId});
    List<NoteModel> list = [];

    for (Map item in dataList) {
      list.add(NoteModel.fromMap(item));
    }

    print("AAAA:$list");

    return list;
  }

  deleteNote(String? id) async {
    Response response =await _service.deleteNote(NoteModel(id: id).toMap());
    return response;
  }
}
