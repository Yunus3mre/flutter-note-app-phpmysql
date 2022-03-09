import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:photo_note_php_mysql/models/user_model.dart';
import 'package:photo_note_php_mysql/services/dbService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInViewModel extends ChangeNotifier {
  final DbService _service = DbService();

  Future<Response> signIn(
      String? email, String? password, bool? rememberMe) async {
    User user = User(email: email, password: password);
    Response response = await _service.signIn(user.toMap());
    Response response2 = await _service.getUserId(user.toMap());

    var userId=jsonDecode(response2.body);
    
    SharedPreferences _sPref = await SharedPreferences.getInstance();
    if (jsonDecode(response.body) == true /*&& rememberMe!*/) {
      _sPref.setBool("isLogged", true);
      _sPref.setString("e", email!);
      _sPref.setString("p", password!);
      _sPref.setString("u", userId);
    }

    

    return response;
  }
}
