// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_note_php_mysql/views/home_page.dart';
import 'package:photo_note_php_mysql/views/update_note_view_model.dart';
import 'package:provider/provider.dart';

class UpdateNote extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController descr = TextEditingController();

  final String? nameText;
  final String? descrText;
  final String? id;

  UpdateNote({Key? key, this.nameText, this.descrText, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    name.text = nameText!;
    descr.text = descrText!;
    return ChangeNotifierProvider(
      create: (context) => UpdateViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text("Not Güncelle"),
        ),
        body: Center(
            child: Form(
                child: Column(
          children: [
            MyTextField(controller: name),
            MyTextField(controller: descr),
            ElevatedButton(
                onPressed: () async {
                  Response response =
                      await Provider.of<UpdateViewModel>(context, listen: false)
                          .updateNote(id, name.text, descr.text);

                  if (jsonDecode(response.body) == true) {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Bilgi Mesajı"),
                          content: Text("Güncelleme İşlemi Başarıyla Yapıldı"),
                        );
                      },
                    );
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                  }else{
                    print(jsonDecode(response.body));
                  }
                },
                child: Text("Güncelle")),
                
          ],
        ))),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;

  MyTextField({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
    );
  }
}
