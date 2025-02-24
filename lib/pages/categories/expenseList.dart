import 'package:flutter/material.dart';
import 'package:moneyapp/db/category_db.dart';
import 'package:moneyapp/models/category_model.dart';

class Expenselist extends StatelessWidget {
  const Expenselist({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categoryListNotifer,
        builder:
            (BuildContext ctx, List<CategoryModel> expenseList, Widget? child) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = expenseList[index];
                return Card(
                  elevation: 30,
                  child: ListTile(
                    onTap: () {},
                    title: Text(data.name),
                    trailing: Text("₹ ${data.amount}"),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return Divider();
              },
              itemCount: expenseList.length);
        });

    //ListView.separated(
    //     itemBuilder: (ctx, index) {
    //       return Card(
    //         child: ListTile(
    //           title: Text('Expense Category Index'),
    //           trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
    //         ),
    //       );
    //     },
    //     separatorBuilder: (ctx, index) {
    //       return const SizedBox(
    //         height: 10,
    //       );
    //     },
    //     itemCount: 20);
  }
}
