import 'package:flutter/material.dart';
import 'package:moneyapp/pages/categories/categories.dart';
import 'package:moneyapp/pages/categories/category_add_popUp.dart';
import 'package:moneyapp/pages/home/widgets/bottomNavigation.dart';
import 'package:moneyapp/pages/transactions/transactions.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [Transactions(), Categories()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Money manager'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print("Add transactions");
          } else if (selectedIndexNotifier.value == 1) {
            print("Add categories");
            showCategoryAddPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext context, int updatedIndex, _) {
              return _pages[updatedIndex];
            }),
      ),
      bottomNavigationBar: Bottomnavigation(),
    );
  }
}
