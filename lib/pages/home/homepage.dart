import 'package:flutter/material.dart';

import 'package:moneyapp/pages/categories/category_add_popUp.dart';
import 'package:moneyapp/pages/categories/expenseList.dart';
import 'package:moneyapp/pages/categories/incomeList.dart';
import 'package:moneyapp/pages/home/widgets/bottomNavigation.dart';
import 'package:moneyapp/pages/settings.dart';
import 'package:moneyapp/pages/transactions/transactions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  static ValueNotifier<String> nameNotifier = ValueNotifier("");
  final _pages = const [Transactions(), Expenselist(), Incomelist()];

  @override
  Widget build(BuildContext context) {
    getName();
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showCategoryAddPopup(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
                  ValueListenableBuilder<String>(
                      valueListenable: nameNotifier,
                      builder: (context, name, _) {
                        return Text(name);
                      }),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return Settings();
                  }));
                },
                icon: Icon(Icons.settings))
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

  Future<void> getName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String a = await sharedPreferences.getString('name').toString();
    if (a == 'null') {
      nameNotifier.value = '';
    } else {
      nameNotifier.value = a;
    }
  }
}
