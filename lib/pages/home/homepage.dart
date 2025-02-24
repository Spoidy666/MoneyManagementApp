import 'package:flutter/material.dart';

import 'package:moneyapp/pages/categories/category_add_popUp.dart';
import 'package:moneyapp/pages/categories/expenseList.dart';
import 'package:moneyapp/pages/categories/incomeList.dart';
import 'package:moneyapp/pages/home/widgets/bottomNavigation.dart';
import 'package:moneyapp/pages/transactions/transactions.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [Transactions(), Expenselist(), Incomelist()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCategoryAddPopup(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Name"),
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.settings))
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: selectedIndexNotifier,
                  builder: (BuildContext context, int updatedIndex, _) {
                    return _pages[updatedIndex];
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavigation(),
    );
  }
}
