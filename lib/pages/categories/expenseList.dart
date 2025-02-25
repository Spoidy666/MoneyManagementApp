import 'package:flutter/material.dart';
import 'package:moneyapp/db/category_db.dart';
import 'package:moneyapp/models/category_model.dart';
import 'package:moneyapp/pages/categories/category_add_popUp.dart';
import 'package:moneyapp/pages/categories/deleteItem.dart';

class Expenselist extends StatelessWidget {
  const Expenselist({super.key});

  @override
  Widget build(BuildContext context) {
    getExpenses();
    return Container(
      color: Colors.black,
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 8, 18, 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        child: ValueListenableBuilder(
            valueListenable: categoryListNotifer,
            builder: (BuildContext ctx, List<CategoryModel> expenseList,
                Widget? child) {
              return ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = expenseList[index];

                    return Card(
                      color: Colors.white,
                      child: GestureDetector(
                        onLongPress: () {
                          deleteItemPopUp(context, data.id!);
                        },
                        child: ListTile(
                          onTap: () {},
                          title: Text(data.name),
                          trailing: Text(
                            "-₹ ${data.amount}",
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: expenseList.length);
            }),
      ),
    );
  }
}
