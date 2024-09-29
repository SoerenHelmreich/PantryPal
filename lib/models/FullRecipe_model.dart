import 'package:cooking_companion/models/NutriInfo_model.dart';

class fullRecipeModel {
  final String title;
  final String description;
  final int duration;
  final List<String> ingredients;
  final List<String> instructions;
  final NutriinfoModel NutritionalInfo;
  final List<String> tips;

  fullRecipeModel({
    required this.title,
    required this.description,
    required this.duration,
    required this.ingredients,
    required this.instructions,
    required this.NutritionalInfo,
    required this.tips,
  });

  factory fullRecipeModel.fromJson(Map<String, dynamic> json) {
    return fullRecipeModel(
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
