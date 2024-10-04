import 'package:cooking_companion/models/nutri_info_model.dart';

class FullRecipeModel {
  final String title;
  final String description;
  final String duration;
  final List<String> ingredients;
  final List<String> instructions;
  final NutriinfoModel NutritionalInfo;
  final List<String> tips;

  FullRecipeModel({
    required this.title,
    required this.description,
    required this.duration,
    required this.ingredients,
    required this.instructions,
    required this.NutritionalInfo,
    required this.tips,
  });

  factory FullRecipeModel.fromJson(Map<String, dynamic> json) {
    return FullRecipeModel(
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
      NutritionalInfo: NutriinfoModel.fromJson(json['NutritionalInfo']),
      tips: List<String>.from(json['tips']),
    );
  }
}
