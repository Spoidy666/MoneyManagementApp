import 'package:flutter/material.dart';
import 'package:moneyapp/db/category/category_db.dart';
import 'package:moneyapp/pages/categories/expenseList.dart';
import 'package:moneyapp/pages/categories/incomeList.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().getCategories().then((value) {
      print('Categories get ${value.toString()}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expenses',
            )
          ],
        ),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: [Incomelist(), Expenselist()]),
        )
      ],
    );
  }
}
