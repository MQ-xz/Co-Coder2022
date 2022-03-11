// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:morse/morse.dart';
import 'package:torch_light/torch_light.dart';
import 'dart:io';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Text2MorseCode';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Enter text here..',
            ),
            controller: text,
          ),
        ),
        RaisedButton(
          child: Text('Submit'),
          onPressed: () {
            String mcodes = Morse(text.text).encode();
            for (var i = 0; i < mcodes.length; i++) {
              String mcode = mcodes[i];
              if (mcode == ".") {
                TorchLight.enableTorch();
                sleep(const Duration(milliseconds: 100));
                TorchLight.disableTorch();
              } else if (mcode == "-") {
                TorchLight.enableTorch();
                sleep(const Duration(milliseconds: 300));
                TorchLight.disableTorch();
              } else if (mcode == " " && mcodes[i + 1] == "." ||
                  mcodes[i + 1] == "-" && mcodes[i - 1] == "." ||
                  mcodes[i + 1] == ".") {
                sleep(const Duration(milliseconds: 100));
              } else if (mcode == " " && mcodes[i + 1] == '/') {
                sleep(const Duration(milliseconds: 600));
              } else {
                sleep(const Duration(milliseconds: 100));
              }
            }
          },
        ),
      ],
    );
  }
}
