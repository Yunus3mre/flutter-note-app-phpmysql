import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:photo_note_php_mysql/models/user_model.dart';
import 'package:photo_note_php_mysql/services/dbService.dart';

class SignUpViewModel extends ChangeNotifier {
  final DbService _service = DbService();

  Future<Response> createUser(
      String name, String email, String password) async {
    User user = User(name: name, email: email, password: password);
    Response response = await _service.createUser(user.toMap());
    return response;
  }
}
