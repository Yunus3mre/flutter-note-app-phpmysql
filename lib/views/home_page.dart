// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:photo_note_php_mysql/models/note_model.dart';
import 'package:photo_note_php_mysql/models/user_model.dart';
import 'package:photo_note_php_mysql/services/dbService.dart';
import 'package:photo_note_php_mysql/views/add_photo_note.dart';
import 'package:photo_note_php_mysql/views/detailed_note_page.dart';
import 'package:photo_note_php_mysql/views/home_page_view_model.dart';
import 'package:photo_note_php_mysql/views/signIn.dart';
import 'package:photo_note_php_mysql/views/signUp.dart';
import 'package:photo_note_php_mysql/views/update_note.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool deleteControl = false;

  List<NoteModel>? list = [];
  String? userId = "";

  Future<void> getId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("u");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      builder: (context, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNewPhotoNote(),
                ));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Notlar"),
          actions: [
            IconButton(onPressed: () async {}, icon: Icon(Icons.person)),
            IconButton(
                onPressed: () async {
                  bool? signOutControl =
                      await Provider.of<DbService>(context, listen: false)
                          .signOut(context);
                  if (signOutControl!) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                        (route) => false);
                  }
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        body: FutureBuilder(
          future: getId(),
          builder: (context, snapshot) => Column(
            children: [
              Expanded(
                child: Center(
                  child: FutureBuilder<dynamic>(
                    future:
                        Provider.of<HomePageViewModel>(context, listen: false)
                            .getData(userId: userId),
                    builder: (context, snapshot) {
                      list = snapshot.data;
                      if (snapshot.hasError) {
                        return Center(child: Text("Bir Hata Meydana Geldi"));
                      } else {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: list!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailedNotePage(
                                          noteName: list![index].noteName,
                                          noteDescr: list![index].noteDescr,
                                        ),
                                      ));
                                },
                                child: Dismissible(
                                  key: UniqueKey(),
                                  confirmDismiss: (direction) async {
                                    deleteControl = await showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            return AlertDialog(
                                              title: Text("Uyarı Mesajı"),
                                              content: Text(
                                                  "Bu Notu Silmek İstiyor musunuz"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                      //true döndürür
                                                    },
                                                    child: Text("Evet")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text("Hayır"))
                                              ],
                                            );
                                          } else {
                                            return AlertDialog(
                                              title: Text("Uyarı Mesajı"),
                                              content: Text(
                                                  "Bu Notu Düzenlemek İstiyor musunuz"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                      //true döndürür
                                                    },
                                                    child: Text("Evet")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text("Hayır"))
                                              ],
                                            );
                                          }
                                        });

                                    return deleteControl;
                                  },
                                  onDismissed: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      Response response =
                                          await Provider.of<HomePageViewModel>(
                                                  context,
                                                  listen: false)
                                              .deleteNote(list![index].id);

                                      setState(() {});
                                    } else if (direction ==
                                        DismissDirection.startToEnd) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdateNote(
                                              nameText: list![index].noteName,
                                              descrText: list![index].noteDescr,
                                              id: list![index].id,
                                            ),
                                          ));
                                      setState(() {});
                                    }
                                  },
                                  background: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit,
                                                color: Colors.white),
                                            Text('Düzenle',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  secondaryBackground: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      color: Colors.red,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Sil",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(width: 3),
                                            Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      textColor: Colors.white,
                                      tileColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      leading: Text((index + 1).toString()),
                                      title: Text(
                                          list![index].noteName ?? "deneme"),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
