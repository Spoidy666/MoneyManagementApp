enum CategoryType { income, expense }

class CategoryModel {
  int? id;
  final String name;
  final bool isDeleted;
  final String amount;
  final CategoryType type;

  CategoryModel({
    required this.name,
    required this.type,
    required this.amount,
    this.isDeleted = false,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'amount': amount,
      'isDeleted': isDeleted ? 1 : 0,
    };
  }

  static CategoryModel fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      type: CategoryType.values
          .firstWhere((e) => e.name == map['type']),
      amount: map['amount'] as String,
      isDeleted: (map['isDeleted'] as int?) == 1, 
    );
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, type: $type, amount: $amount, isDeleted: $isDeleted)';
  }
}
