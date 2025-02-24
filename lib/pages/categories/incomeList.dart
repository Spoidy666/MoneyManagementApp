import 'package:flutter/material.dart';
import 'package:moneyapp/db/category_db.dart';
import 'package:moneyapp/models/category_model.dart';

class Incomelist extends StatelessWidget {
  const Incomelist({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: IncomecategoryListNotifer,
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
  }
}
