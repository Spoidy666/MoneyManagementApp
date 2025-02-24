import 'package:flutter/material.dart';
import 'package:moneyapp/models/category_model.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

ValueNotifier<List<CategoryModel>> categoryListNotifer = ValueNotifier([]);
ValueNotifier<List<CategoryModel>> IncomecategoryListNotifer =
    ValueNotifier([]);
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
}

Future<void> getExpenses() async {
  final _values = await _db.rawQuery('SELECT * FROM CATEGORY');
  print("All Categories from DB: $_values");
  categoryListNotifer.value.clear();
  for (var map in _values) {
    final user = CategoryModel.fromMap(map);

    categoryListNotifer.value.add(user);
  }
  categoryListNotifer.notifyListeners();
}

Future<void> addNewIncome(CategoryModel value) async {
  final int id = await _db.rawInsert(
      'INSERT INTO CATEGORY(name,type,amount) VALUES(?,?,?)',
      [value.name, value.type.name, value.amount]);
  value.id = id;

  getIncome();
}

Future<void> getIncome() async {
  final _values = await _db.rawQuery('SELECT * FROM CATEGORY');
  print("All Categories from DB: $_values");
  IncomecategoryListNotifer.value.clear();
  for (var map in _values) {
    final user = CategoryModel.fromMap(map);
    IncomecategoryListNotifer.value.add(user);
  }
  IncomecategoryListNotifer.notifyListeners();
}
