enum CategoryType { income, expense }

enum transferType { cash, card,upi }

class CategoryModel {
  int? id;
  final String name;
  final transferType ttype;
  final String amount;
  final CategoryType type;
  final DateTime date;

  CategoryModel({
    required this.name,
    required this.type,

    required this.ttype,
    required this.amount,
    required this.date,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'ttype':ttype.name,
      'date': date.toIso8601String().split(" ")[0],
      'amount': amount,
    };
  }

  static CategoryModel fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      type: CategoryType.values.firstWhere((e) => e.name == map['type']),
      ttype: transferType.values.firstWhere((e) => e.name == map['ttype']),
      date: DateTime.parse(map['date'] as String),
      amount: map['amount'] as String,
    );
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, type: $type, amount: $amount,)';
  }
}
