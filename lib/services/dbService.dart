import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_note_php_mysql/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:photo_note_php_mysql/views/signIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbService extends ChangeNotifier {
  static const root = "http://10.0.2.2/photoNote/";
  static const url = "${root}signUp.php";
  static const signInUrl = "${root}signIn.php";
  static const getDataUrl = "${root}getdata.php";
  static const createNoteUrl = "${root}createNewNote.php";
  static const getUserIdUrl = "${root}getUserId.php";
  static const deleteNoteUrl = "${root}deleteNote.php";
  static const updateNoteUrl = "${root}update.php";

  Future<Response> createUser(Map map) async {
    Response response = await http.post(
      Uri.parse(url),
      body: json.encode(map),
    );

    return response;
  }

  Future<Response> signIn(Map map) async {
    Response response = await http.post(
      Uri.parse(signInUrl),
      body: json.encode(map),
    );
    return response;
  }

  Future<bool?> signOut(BuildContext context) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    bool? logOutControl = await _sharedPreferences.clear();

    return logOutControl;
  }

  Future<List> getData(Map map) async {
    Response response =
        await http.post(Uri.parse(getDataUrl), body: json.encode(map));
    List dataList = jsonDecode(response.body);

    return dataList;
  }

  Future<Response> createNote(Map map) async {
    Response response = await http.post(
      Uri.parse(createNoteUrl),
      body: json.encode(map),
    );
    return response;
  }

  getUserId(Map map) async {
    Response response = await http.post(
      Uri.parse(getUserIdUrl),
      body: json.encode(map),
    );
    return response;
  }

  Future<Response> deleteNote(Map map) async {
    Response response = await http.post(
      Uri.parse(deleteNoteUrl),
      body: json.encode(map),
    );
    return response;
  }

  Future<Response> updateNote(Map map) async {
    Response response = await http.post(
      Uri.parse(updateNoteUrl),
      body: json.encode(map),
    );
    return response;
  }
}
