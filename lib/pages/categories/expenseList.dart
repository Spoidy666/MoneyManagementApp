import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneyapp/db/category_db.dart';
import 'package:moneyapp/models/category_model.dart';
import 'package:moneyapp/pages/categories/deleteItem.dart';
import 'package:moneyapp/pages/categories/pieChartExpenses.dart';

class Expenselist extends StatelessWidget {
  const Expenselist({super.key});

  @override
  Widget build(BuildContext context) {
    getExpenses();
    getExpenseSummary();
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(color: Colors.white, child: ExpensePieChart()),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.fromLTRB(18, 8, 18, 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: ValueListenableBuilder(
                valueListenable: categoryListNotifer,
                builder: (BuildContext ctx, List<CategoryModel> expenseList,
                    Widget? child) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: expenseList.length,
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
                                subtitle: Text(data.ttype.name.toUpperCase()),
                                trailing: Text(
                                  "-₹${data.amount}",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
