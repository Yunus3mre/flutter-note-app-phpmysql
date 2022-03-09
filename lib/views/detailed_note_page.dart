// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DetailedNotePage extends StatelessWidget {
  final String? noteName;
  final String? noteDescr;

  const DetailedNotePage({Key? key, this.noteName, this.noteDescr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
      appBar: AppBar(
        title: Text("Note Detayları"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyTextFieldWidget(text: noteName),
            Divider(
              height: 20,
              thickness: 2,
            ),
            MyTextFieldWidget(text: noteDescr),
          ],
        ),
      )),
    );
  }
}

class MyTextFieldWidget extends StatelessWidget {
  const MyTextFieldWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(12)),
      child: Text(
        text!,
        maxLines: 5,
        style: TextStyle(fontSize: 25, color: Colors.black),
      ),
    );
  }
}
