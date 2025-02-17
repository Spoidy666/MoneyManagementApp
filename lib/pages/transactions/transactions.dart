import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (ctx, index) {
          return const Card(
            elevation: 20,
            child: ListTile(
                leading: Text('15-02-2025'),
                title: Text('Amount spend'),
                subtitle: Text('Travel')),
          );
        },
        separatorBuilder: (ctx, index) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: 10);
  }
}
