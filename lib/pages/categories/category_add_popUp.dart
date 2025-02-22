import 'package:flutter/material.dart';
import 'package:moneyapp/models/category/category_model.dart';

ValueNotifier<CategoryType> selectCategoryNotifer =
    ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameeditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameeditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Category Name'),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    RadioButton(title: 'Income', type: CategoryType.income),
                    RadioButton(title: 'Expenses', type: CategoryType.expense)
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {}, child: Text('Add')),
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
