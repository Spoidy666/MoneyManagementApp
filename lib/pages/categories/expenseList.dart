import 'package:flutter/material.dart';

class Expenselist extends StatelessWidget {
  const Expenselist({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              title: Text('Expense Category Index'),
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
