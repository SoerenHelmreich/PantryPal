import 'dart:convert';

import 'package:cooking_companion/models/completion_model.dart';
import 'package:cooking_companion/models/ingredient_model.dart';
import 'package:cooking_companion/models/nutri_info_model.dart';
import 'package:cooking_companion/models/prompt_settings_model.dart';
import 'package:cooking_companion/services/api_models.dart';

class FullRecipeModel {
  String title;
  String description;
  String duration;
  List<Ingredient> ingredients;
  List<String> instructions;
  NutriinfoModel nutritionalInfo =
      NutriinfoModel(calories: 0, fat: 0, carbohydrates: 0, protein: 0);
  List<String> tips = [];

  //Initialize FullRecipeModel with default values for optional variables
  FullRecipeModel({
    required this.title,
    required this.description,
    required this.duration,
    this.ingredients = const [],
    this.instructions = const [],
    NutriinfoModel? nutritionalInfo,
    this.tips = const [],
  }) : nutritionalInfo = nutritionalInfo ??
            NutriinfoModel(calories: 0, fat: 0, carbohydrates: 0, protein: 0);

  factory FullRecipeModel.fromJson(Map<String, dynamic> json) {
    return FullRecipeModel(
      title: json['title'] ?? "Title",
      description: json['description'] ?? "Description",
      duration: json['duration'] ?? "0 Minutes",
      ingredients: json['ingredients'] != null
          ? List<Ingredient>.from(
              json['ingredients'].map((item) => Ingredient.fromJson(item)))
          : [],
      instructions: json['instructions'] != null
          ? List<String>.from(json['instructions'])
          : [],
      nutritionalInfo: json['NutritionalInfo'] != null
          ? NutriinfoModel.fromJson(json['NutritionalInfo'])
          : NutriinfoModel(calories: 0, fat: 0, carbohydrates: 0, protein: 0),
      tips: json['tips'] != null ? List<String>.from(json['tips']) : [],
    );
  }

  static Future<FullRecipeModel> createWithAPI({
    required String title,
    required String description,
    required String duration,
    required PromptSettingsModel promptSetting,
  }) async {
    // Call the OpenAI API to get additional data
    CompletionModel completion =
        await ApiService.createCompletion(promptSetting: promptSetting);

    // Parse the response and initialize the FullRecipeModel
    Map<String, dynamic> jsonResponse = jsonDecode(completion.message);

    return FullRecipeModel(
      title: title,
      description: description,
      duration: duration,
      ingredients: jsonResponse['ingredients'] != null
          ? List<Ingredient>.from(jsonResponse['ingredients']
              .map((item) => Ingredient.fromJson(item)))
          : [],
      instructions: jsonResponse['instructions'] != null
          ? List<String>.from(jsonResponse['instructions'])
          : [],
      nutritionalInfo: jsonResponse['NutritionalInfo'] != null
          ? NutriinfoModel.fromJson(jsonResponse['NutritionalInfo'])
          : NutriinfoModel(calories: 0, fat: 0, carbohydrates: 0, protein: 0),
      tips: jsonResponse['tips'] != null
          ? List<String>.from(jsonResponse['tips'])
          : [],
    );
  }
}
