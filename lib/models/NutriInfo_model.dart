class NutriinfoModel {
  final String calories;
  final String fat;
  final String carbohydrates;
  final String protein;

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
