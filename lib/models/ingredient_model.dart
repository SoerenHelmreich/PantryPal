class Ingredient {
  Ingredient({required this.name, required this.amount});

  final String name;
  final String amount;

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(name: json['name'], amount: json['amount']);
  }
}
