import 'package:flutter/material.dart';
import 'package:moneyapp/db/category_db.dart';
import 'package:moneyapp/models/category_model.dart';
import 'package:intl/intl.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    getHistory();
    getTotalAmount();
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Available balance",
                            ),
                            Container(
                              child: ValueListenableBuilder<int>(
                                valueListenable: totalAmountNotifier,
                                builder: (context, totalAmount, child) {
                                  return Text(
                                    "₹$totalAmount",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Transaction History",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(18, 0, 18, 4),
                          child: ValueListenableBuilder(
                              valueListenable: historycategoryListNotifer,
                              builder: (BuildContext ctx,
                                  List<CategoryModel> expenseList,
                                  Widget? child) {
                                if (expenseList.isEmpty) {
                                  return Center(
                                      child: Text(
                                          'Click on "+" to add a new entry'));
                                }
                                return ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (ctx, index) {
                                      final data = expenseList[index];
                                      final currentMonth =
                                          DateFormat('MMMM yyyy')
                                              .format(data.date);

                                      // Determine if a month header should be inserted
                                      bool showMonthHeader = index == 0 ||
                                          DateFormat('MMMM yyyy').format(
                                                  expenseList[index - 1]
                                                      .date) !=
                                              currentMonth;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (showMonthHeader)
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8),
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
                                            borderOnForeground: true,
                                            color: Colors.white,
                                            child: ListTile(
                                              onTap: () {},
                                              title: Text(data.name),
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.accents[
                                                    expenseList.indexOf(data) %
                                                        Colors.accents.length],
                                                child: Text(
                                                  DateFormat('dd')
                                                      .format(data.date),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              subtitle: Text(data.ttype.name
                                                  .toUpperCase()),
                                              trailing: Text(
                                                "${data.type == CategoryType.expense ? '-' : '+'}₹${data.amount}",
                                                style: TextStyle(
                                                    color: data.type ==
                                                            CategoryType.expense
                                                        ? Colors.red
                                                        : Colors
                                                            .green, // ✅ Red for expense, Green for income
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
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
                              })),
                    ),
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
