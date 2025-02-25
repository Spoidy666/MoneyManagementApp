import 'package:flutter/material.dart';
import 'package:moneyapp/models/category_model.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

ValueNotifier<List<CategoryModel>> categoryListNotifer = ValueNotifier([]);
ValueNotifier<List<CategoryModel>> IncomecategoryListNotifer =
    ValueNotifier([]);
ValueNotifier<List<CategoryModel>> historycategoryListNotifer =
    ValueNotifier([]);
ValueNotifier<int> totalAmountNotifier = ValueNotifier(0);
late Database _db;
Future<void> initializedbCatogory() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'category.db');
  _db = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE CATEGORY(id INTEGER PRIMARY KEY,name TEXT,type TEXT,amount TEXT)');
    },
  );
}

Future<void> addNewExpense(CategoryModel value) async {
  final int id = await _db.rawInsert(
      'INSERT INTO CATEGORY(name,type,amount) VALUES(?,?,?)',
      [value.name, value.type.name, value.amount]);
  value.id = id;

  getExpenses();
  getHistory();
  getIncome();
  getTotalAmount();
}

Future<void> getExpenses() async {
  final _values = await _db.rawQuery('SELECT * FROM CATEGORY order by id desc');
  print("All Categories from DB: $_values");
  categoryListNotifer.value.clear();
  for (var map in _values) {
    final user = CategoryModel.fromMap(map);
    if (user.type == CategoryType.expense) {
      categoryListNotifer.value.add(user);
    }
  }
  categoryListNotifer.notifyListeners();
}

Future<void> getIncome() async {
  final _values = await _db.rawQuery('SELECT * FROM CATEGORY order by id desc');
  print("All Categories from DB: $_values");
  IncomecategoryListNotifer.value.clear();
  for (var map in _values) {
    final user = CategoryModel.fromMap(map);
    if (user.type == CategoryType.income) {
      IncomecategoryListNotifer.value.add(user);
    }
  }
  IncomecategoryListNotifer.notifyListeners();
}

Future<void> getHistory() async {
  final _values = await _db.rawQuery('SELECT * FROM CATEGORY ORDER BY id desc');
  print("All Categories from DB: $_values");
  historycategoryListNotifer.value.clear();
  for (var map in _values) {
    final user = CategoryModel.fromMap(map);

    historycategoryListNotifer.value.add(user);
  }
  historycategoryListNotifer.notifyListeners();
}

Future<void> getTotalAmount() async {
  final _values = await _db.rawQuery('SELECT * FROM CATEGORY');
  int sum = 0;
  for (var map in _values) {
    final user = CategoryModel.fromMap(map);
    if (user.type == CategoryType.income) {
      sum += int.tryParse(user.amount) ?? 0;
    } else {
      sum -= int.tryParse(user.amount) ?? 0;
    }
  }
  totalAmountNotifier.value = sum;
}

Future<void> deleteItem(int id) async {
  _db.rawDelete('DELETE FROM CATEGORY WHERE id=?', [id]);
  getExpenses();
  getHistory();
  getIncome();
  getTotalAmount();

}
