import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyapp/db/category_db.dart';
import 'package:moneyapp/models/category_model.dart';
import 'package:moneyapp/pages/categories/deleteItem.dart';

class Incomelist extends StatelessWidget {
  const Incomelist({super.key});

  @override
  Widget build(BuildContext context) {
    getIncome();
    return Container(
      color: Colors.black,
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 8, 18, 4),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        child: ValueListenableBuilder(
            valueListenable: IncomecategoryListNotifer,
            builder: (BuildContext ctx, List<CategoryModel> expenseList,
                Widget? child) {
              if (expenseList.isEmpty) {
                return Center(child: Text('Click on "+" to add a new entry'));
              }

              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final data = expenseList[index];
                    final currentMonth =
                        DateFormat('MMMM yyyy').format(data.date);

                    // Determine if a month header should be inserted
                    bool showMonthHeader = index == 0 ||
                        DateFormat('MMMM yyyy')
                                .format(expenseList[index - 1].date) !=
                            currentMonth;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showMonthHeader)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              currentMonth,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        Card(
                          color: Colors.white,
                          child: GestureDetector(
                            onLongPress: () {
                              deleteItemPopUp(context, data.id!);
                            },
                            child: ListTile(
                              onTap: () {},
                              title: Text(data.name),
                              leading: CircleAvatar(
                                backgroundColor: Colors.accents[
                                    expenseList.indexOf(data) %
                                        Colors.accents.length],
                                child: Text(
                                  DateFormat('dd').format(data.date),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              trailing: Text("+₹${data.amount}",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15)),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: expenseList.length);
            }),
      ),
    );
  }
}
