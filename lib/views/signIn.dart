// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_note_php_mysql/views/home_page.dart';
import 'package:photo_note_php_mysql/views/signUp.dart';
import 'package:photo_note_php_mysql/views/sign_in_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  bool? checkBoxControl = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text("Giriş Yap"),
        ),
        body: Form(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email",
                  ),
                  controller: email,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Şifre",
                  ),
                  controller: password,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Response response = await Provider.of<SignInViewModel>(
                              context,
                              listen: false)
                          .signIn(email.text, password.text, checkBoxControl);
                      var mesaj = jsonDecode(response.body);

                      if (!mesaj) {
                        await showDialog(
                            context: context,
                            builder: (contex) {
                              return AlertDialog(
                                title: Text("HATA"),
                                content: Text("Şifre ya da E posta Hatalı"),
                              );
                            });
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                      }
                    },
                    child: Text("Giriş Yap")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: checkBoxControl,
                      onChanged: (value) {
                        checkBoxControl = value;
                        setState(() {});
                      },
                    ),
                    Text("Beni Hatırla"),
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                    },
                    child: Text("Kayıt Ol")),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
