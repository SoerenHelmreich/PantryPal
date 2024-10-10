import 'dart:convert';

import 'package:cooking_companion/models/completion_model.dart';
import 'package:cooking_companion/models/ingredient_model.dart';
import 'package:cooking_companion/models/nutri_info_model.dart';
import 'package:cooking_companion/models/prompt_settings.dart';
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

  static Future<FullRecipeModel> createWithAPI(
      {required String userPrompt}) async {
    // Call the OpenAI API to get additional data
    CompletionModel completion = await ApiService.createCompletion(
        systemPrompt: PromptSettings().recipeCreationSystemPrompt,
        userPrompt: userPrompt,
        returnFormat: PromptSettings().recipeCreationJsonSchema);

    // Parse the response and initialize the FullRecipeModel
    Map<String, dynamic> jsonResponse = jsonDecode(completion.message);

    return FullRecipeModel(
      title: jsonResponse['title'] ?? "Title",
      description: jsonResponse['description'] ?? "Description",
      duration: jsonResponse['duration'] ?? "0 Minutes",
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

  Future<void> fillRecipeDetails({required String userPrompt}) async {
    CompletionModel completion = await ApiService.createCompletion(
        systemPrompt: PromptSettings().recipeDetailsSystemPrompt,
        userPrompt: userPrompt,
        returnFormat: PromptSettings().recipeDetailsJsonSchema);

    // Parse the response and initialize the FullRecipeModel
    Map<String, dynamic> jsonResponse = jsonDecode(completion.message);

    this.ingredients = List<Ingredient>.from(
        jsonResponse['ingredients'].map((item) => Ingredient.fromJson(item)));

    this.instructions = List<String>.from(jsonResponse['instructions']);

    this.nutritionalInfo =
        NutriinfoModel.fromJson(jsonResponse['NutritionalInfo']);

    this.tips = List<String>.from(jsonResponse['tips']);
  }
}
