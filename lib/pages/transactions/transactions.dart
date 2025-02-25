import 'package:flutter/material.dart';
import 'package:moneyapp/db/category_db.dart';
import 'package:moneyapp/models/category_model.dart';

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
                                    "₹ $totalAmount",
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
                                return ListView.separated(
                                    itemBuilder: (ctx, index) {
                                      final data = expenseList[index];
                                      return Card(
                                        borderOnForeground: true,
                                        color: Colors.white,
                                        child: ListTile(
                                          onTap: () {},
                                          title: Text(data.name),
                                          trailing: Text(
                                            "${data.type == CategoryType.expense ? '-' : ''}₹ ${data.amount}",
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
