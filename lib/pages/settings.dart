import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 100,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(130, 140, 10, 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                        iconSize: 30,
                        onPressed: () {},
                        icon: Icon(Icons.add_a_photo)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Change name'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  saveName(_nameController.text.trim());
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black)),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Restart the app for changes"),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveName(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('name', name);
  }

  Future<String> getName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final a = await sharedPreferences.getString('name');
    return a.toString();
  }
}
