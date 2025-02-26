import 'package:flutter/material.dart';
import 'package:moneyapp/db/category_db.dart';
import 'package:moneyapp/models/category_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/utils/utils.dart';

ValueNotifier<CategoryType> selectCategoryNotifer =
    ValueNotifier(CategoryType.expense);
ValueNotifier<transferType> selectTransferNotifer =
    ValueNotifier(transferType.upi);
ValueNotifier<DateTime> selectedDateNotifier = ValueNotifier(DateTime.now());
Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameeditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  final _dateEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: Text('Add new'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameeditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Title'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _amountEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Amount'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _dateEditingController,
                readOnly: true,
                onTap: () {
                  selectDate(context, _dateEditingController);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Date'),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Transfertype(title: 'UPI', type: transferType.upi),
                    Transfertype(title: 'Cash', type: transferType.cash),
                    Transfertype(title: 'Card', type: transferType.card),
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    RadioButton(title: 'Expenses', type: CategoryType.expense),
                    RadioButton(title: 'Income', type: CategoryType.income)
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_nameeditingController.text.trim().isEmpty) {
                    snack(context, 'please enter a name ');
                  } else if (_amountEditingController.text.trim().isEmpty) {
                    snack(context, 'Enter the amount idiot');
                  } else if (num.tryParse(
                          _amountEditingController.text.trim()) ==
                      null) {
                    snack(context, "Enter an integer value for amount");
                  } else {
                    if (selectCategoryNotifer.value == CategoryType.expense) {
                      final _name = _nameeditingController.text.trim();
                      final _type = CategoryType.expense;
                      final _amount = _amountEditingController.text.trim();
                      final _values = CategoryModel(
                          ttype: selectTransferNotifer.value,
                          name: _name,
                          type: _type,
                          amount: _amount,
                          date: selectedDateNotifier.value);
                      Navigator.of(context).pop();

                      addNewExpense(_values);
                    } else if (selectCategoryNotifer.value ==
                        CategoryType.income) {
                      final _name = _nameeditingController.text.trim();
                      final _type = CategoryType.income;
                      final _amount = _amountEditingController.text.trim();
                      final _values = CategoryModel(
                          name: _name,
                          type: _type,
                          ttype: selectTransferNotifer.value,
                          amount: _amount,
                          date: selectedDateNotifier.value);

                      addNewExpense(_values);
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black)),
              ),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectCategoryNotifer,
            builder: (BuildContext ctx, CategoryType newCategory, _) {
              return Radio<CategoryType>(
                  activeColor: Colors.black,
                  value: type,
                  groupValue: selectCategoryNotifer.value,
                  onChanged: (value) {
                    if (value != null) {
                      selectCategoryNotifer.value = value;
                      selectCategoryNotifer.notifyListeners();
                    } else {
                      return;
                    }
                  });
            }),
        Text(title),
      ],
    );
  }
}

class Transfertype extends StatelessWidget {
  final String title;
  final transferType type;
  const Transfertype({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectTransferNotifer,
            builder: (BuildContext ctx, transferType newCategory, _) {
              return Radio<transferType>(
                  activeColor: Colors.black,
                  value: type,
                  groupValue: selectTransferNotifer.value,
                  onChanged: (value) {
                    if (value != null) {
                      selectTransferNotifer.value = value;
                      selectTransferNotifer.notifyListeners();
                    } else {
                      return;
                    }
                  });
            }),
        Text(title),
      ],
    );
  }
}

void snack(context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.fixed,
  ));
}

Future<void> selectDate(
    BuildContext context, TextEditingController controller) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  if (picked != null) {
    selectedDateNotifier.value = picked;
    controller.text = picked.toString().split(" ")[0];
  }
}
