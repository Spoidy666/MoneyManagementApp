import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text("Set Name"),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  saveName(_nameController.text.trim());
                },
                child: Text(
                  "save",
                  style: TextStyle(color: Colors.black),
                )),
            SizedBox(
              height: 20,
            ),
            Text("Restart the app for changes"),
          ],
        ),
      ),
    );
  }
}

Future<void> saveName(String name) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('name', name);
}
