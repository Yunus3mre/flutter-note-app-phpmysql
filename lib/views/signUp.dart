// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:photo_note_php_mysql/models/user_model.dart';
import 'package:photo_note_php_mysql/views/signIn.dart';
import 'package:photo_note_php_mysql/views/sign_up_view_model.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool control = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text("Kayıt Ol"),
        ),
        body: Form(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "İsim",
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email",
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Şifre",
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await userRegister(context);
                    },
                    child: Text("Kayıt Ol")),
                control ? CircularProgressIndicator() : Center(),
              ],
            ),
          )),
        ),
      ),
    );
  }

  userRegister(BuildContext context) async {
    String nameText = name.text;
    String emailText = email.text;
    String passwordText = password.text;

    setState(() {
      control = true;
    });

    Response response =
        await Provider.of<SignUpViewModel>(context, listen: false)
            .createUser(nameText, emailText, passwordText);

    if (response.statusCode == 200) {
      setState(() {
        control = false;
      });
    }
    var responseMessage = jsonDecode(response.body);

    await showDialog(
        context: context,
        builder: (contex) {
          return AlertDialog(
            title: responseMessage == true
                ? Text("Kayıt Başarılı")
                : responseMessage == false
                    ? Text("Bu Email İle Kayıtlı Bir Hesap Bulunmaktadır")
                    : Text("Bir Hata Meydana Geldi.Lütfen Tekrar Deneyin."),
          );
        });

    if (responseMessage == "true") {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignIn()));
    } else {
      Navigator.pop(context);
    }
  }
}
