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
ValueNotifier<Map<String, double>> expenseDataNotifier = ValueNotifier({});

late Database _db;
Future<void> initializedbCatogory() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'category.db');
  _db = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE CATEGORY(id INTEGER PRIMARY KEY,name TEXT,type TEXT,amount TEXT,date TEXT,ttype TEXT)');
    },
  );
}

Future<void> addNewExpense(CategoryModel value) async {
  final int id = await _db.rawInsert(
      'INSERT INTO CATEGORY(name,type,amount,date,ttype) VALUES(?,?,?,?,?)', [
    value.name,
    value.type.name,
    value.amount,
    value.date.toIso8601String(),
    value.ttype.name,
  ]);
  value.id = id;

  getExpenses();
  getHistory();
  getIncome();
  getTotalAmount();
  await getExpenseSummary();
}

Future<void> getExpenses() async {
  final _values =
      await _db.rawQuery('SELECT * FROM CATEGORY ORDER BY date desc,id desc');
      
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
  final _values =
      await _db.rawQuery('SELECT * FROM CATEGORY order by date desc,id desc');
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
  final _values =
      await _db.rawQuery('SELECT * FROM CATEGORY ORDER BY date desc,id desc');
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
  getExpenseSummary();
}

Future<void> getExpenseSummary() async {
  final db = await initializedbCatogory();
  final List<Map<String, dynamic>> queryResult = await _db.rawQuery(
      'SELECT LOWER(name) as name, SUM(amount) as total FROM CATEGORY WHERE type="expense" GROUP BY LOWER(name)');

  Map<String, double> updatedData = {}; // Change to double
  for (var row in queryResult) {
    updatedData[row['name']] =
        (row['total'] as num).toDouble(); // Convert to double
  }

  expenseDataNotifier.value = updatedData;
}
