import 'package:flutter/material.dart';
import 'package:moneyapp/db/category_db.dart';
import 'package:moneyapp/models/category_model.dart';

ValueNotifier<CategoryType> selectCategoryNotifer =
    ValueNotifier(CategoryType.expense);
Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameeditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Add new'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameeditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _amountEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Amount'),
              ),
            ),
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
                    } else {
                      if (selectCategoryNotifer.value == CategoryType.expense) {
                        final _name = _nameeditingController.text.trim();
                        final _type = CategoryType.expense;
                        final _amount = _amountEditingController.text.trim();
                        final _values = CategoryModel(
                            name: _name, type: _type, amount: _amount);
                        Navigator.of(context).pop();

                        addNewExpense(_values);
                      } else if (selectCategoryNotifer.value ==
                          CategoryType.income) {
                        final _name = _nameeditingController.text.trim();
                        final _type = CategoryType.income;
                        final _amount = _amountEditingController.text.trim();
                        final _values = CategoryModel(
                            name: _name, type: _type, amount: _amount);

                        addNewExpense(_values);
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: Text('Add')),
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

void snack(context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.fixed,
  ));
}
