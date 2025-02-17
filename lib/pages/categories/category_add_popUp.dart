import 'package:flutter/material.dart';
import 'package:moneyapp/models/category/category_model.dart';

Future<void> showCategoryAddPopup(BuildContext context) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
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

class RadioButton extends StatefulWidget {
  final String title;
  final CategoryType type;
  const RadioButton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

CategoryType? _type;

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<CategoryType>(
            value: widget.type,
            groupValue: _type,
            onChanged: (value) {
              setState(() {
                _type = value;
              });
            }),
        Text(widget.title),
      ],
    );
  }
}
