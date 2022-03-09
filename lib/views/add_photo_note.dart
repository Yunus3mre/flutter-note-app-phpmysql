// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_note_php_mysql/views/add_photo_note_view_model.dart';
import 'package:photo_note_php_mysql/views/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewPhotoNote extends StatefulWidget {
  const AddNewPhotoNote({Key? key}) : super(key: key);

  @override
  _AddNewPhotoNoteState createState() => _AddNewPhotoNoteState();
}

class _AddNewPhotoNoteState extends State<AddNewPhotoNote> {
  TextEditingController name = TextEditingController();
  TextEditingController descr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? url = "deneme";
  int? id = 1;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<addNoteViewModel>(
      create: (context) => addNoteViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text("Yeni Not Ekle"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 50),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  CustomizableTextField(
                    minLines: 1,
                    hintText: "Not Başlık",
                    controller: name,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomizableTextField(
                    minLines: 5,
                    controller: descr,
                    hintText: "Not Açıklama",
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await addNewNoteMethod(context);
                        }
                      },
                      child: Text("Kaydet"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addNewNoteMethod(BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? email = _pref.getString("e");
    String? password = _pref.getString("p");

    Response response =
        await Provider.of<addNoteViewModel>(context, listen: false)
            .createNewNote(name.text, descr.text, url, email, password);

    if (jsonDecode(response.body) == true) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Kayıt Başarılı"),
        ),
      );

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Kayıt Başarısız"),
        ),
      );

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    }
  }
}

class CustomizableTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final int? minLines;
  const CustomizableTextField(
      {Key? key, this.hintText, this.controller, this.minLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        validator: (value) {
          if (value?.length == 0 || value!.isEmpty) {
            return "Bu Alan Boş Bırakılamaz.";
          } else {
            return null;
          }
        },
        minLines: minLines,
        maxLines: 5,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
