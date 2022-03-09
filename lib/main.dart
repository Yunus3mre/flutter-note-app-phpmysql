import 'package:flutter/material.dart';
import 'package:photo_note_php_mysql/services/dbService.dart';
import 'package:photo_note_php_mysql/views/home_page.dart';
import 'package:photo_note_php_mysql/views/signIn.dart';
import 'package:photo_note_php_mysql/views/signUp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool? isLogged = sharedPreferences.getBool("isLogged");

  runApp(MyApp(
    isLogged: isLogged,
  ));
}

class MyApp extends StatelessWidget {
  bool? isLogged;

  MyApp({Key? key, this.isLogged}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DbService>(
      create: (context) => DbService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: isLogged == true ? HomePage() : SignIn(),
      ),
    );
  }
}
