class NutriinfoModel {
  final int calories;
  final int fat;
  final int carbohydrates;
  final int protein;

  NutriinfoModel({
    required this.calories,
    required this.fat,
    required this.carbohydrates,
    required this.protein,
  });

  factory NutriinfoModel.fromJson(Map<String, dynamic> json) {
    return NutriinfoModel(
      calories: json['calories'],
      fat: json['fat'],
      carbohydrates: json['carbohydrates'],
      protein: json['protein'],
    );
  }
}
