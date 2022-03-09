import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:photo_note_php_mysql/services/dbService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addNoteViewModel extends ChangeNotifier {
  DbService _service = DbService();
  Future<Response> createNewNote(String? noteName, String? noteDescr,
      String? url, String? email, String? password) async {
   // Response userId =await _service.getUserId({"email": email, "password": password});

    //int id = int.parse(jsonDecode(userId.body));

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    print("USER_ID:${sharedPreferences.getString("u")}");
    print("USER_ID:${sharedPreferences.getString("u")}");
    print("USER_ID:${sharedPreferences.getString("u")}");

    Response response = await _service.createNote({
      "user_id": sharedPreferences.getString("u"),
      "note_name": noteName,
      "note_descr": noteDescr,
      "url": url
    });
    return response;
  }
}
