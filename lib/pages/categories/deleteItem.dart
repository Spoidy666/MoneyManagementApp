import 'package:flutter/material.dart';
import 'package:moneyapp/db/category_db.dart';

Future<void> deleteItemPopUp(BuildContext context, int id) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: Text('Do you want to delete this entry?'),
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      return Navigator.pop(context);
                    },
                    child: Text(
                      'No',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      deleteItem(id);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            const Color.fromARGB(255, 0, 0, 0))),
                  )
                ],
              ),
            )
          ],
        );
      });
}
