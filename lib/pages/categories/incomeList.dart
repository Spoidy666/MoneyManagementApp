import 'package:flutter/material.dart';

class Incomelist extends StatelessWidget {
  const Incomelist({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              title: Text('Income Category Index'),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 20);
  }
}
