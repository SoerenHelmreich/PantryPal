import 'dart:convert';

import 'package:cooking_companion/models/completion_model.dart';
import 'package:cooking_companion/models/full_recipe_model.dart';
import 'package:cooking_companion/models/nutri_info_model.dart';
import 'package:cooking_companion/models/prompt_settings_model.dart';
import 'package:cooking_companion/models/short_recipe_model.dart';
import 'package:cooking_companion/pages/recipe_detail.dart';
import 'package:cooking_companion/services/api_models.dart';
import 'package:cooking_companion/widgets/recipe_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RecipeOverview extends StatelessWidget {
  const RecipeOverview({super.key, required this.recipeOverview});

  final List<ShortRecipeModel> recipeOverview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Overview"),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 1, // Number of columns
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 5.0,
        itemCount: recipeOverview.length,
        itemBuilder: (context, index) {
          final recipe = recipeOverview[index];
          return RecipePreviewCard(
            recipeSuggestion: recipe,
            gotoRecipeDetails: () =>
                getRecipeDetails(context, recipeOverview[index].description),
          );
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(
          1,
        ),
      ),
    );
  }
}

Future<FullRecipeModel> getRecipeDetails(
    BuildContext context, String userPrompt) async {
  String systemPrompt =
      """You are a professional chef. The user wants to cook something, but only has a few ingredients available. You have already recommended four recipes to the user, and they have selected one of them. You will get the description and the title as a prompt to create the full recipe details. 
You give a list of ingredients needed (in the metric system), add a List of instructions, add the nutritional info for one serving (including calories, fat, carbohydrates, protein) and give a list of tips that might make it easier to cook the dish or give relevant side information.
Please keep dietary requirements in mind when they are stated in the description. Feel free to add other ingredients the user might have to buy. Please return your answer in a json object that can be displayed in a web application.""";

  Object returnFormat = {
    "type": "json_schema",
    "json_schema": {
      "name": "DetailedRecipe",
      "schema": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "The title of the recipe."
          },
          "description": {
            "type": "string",
            "description": "A brief description of the recipe."
          },
          "duration": {
            "type": "string",
            "description":
                "The duration to prepare the recipe, expressed as a string (e.g., '30 minutes')."
          },
          "ingredients": {
            "type": "array",
            "items": {"type": "string"},
            "description": "List of ingredients required for the recipe."
          },
          "instructions": {
            "type": "array",
            "items": {"type": "string"},
            "description": "Step-by-step instructions to prepare the recipe."
          },
          "NutritionalInfo": {
            "type": "object",
            "properties": {
              "calories": {
                "type": "number",
                "description": "The amount of calories in the recipe."
              },
              "fat": {
                "type": "number",
                "description": "The amount of fat in the recipe (grams)."
              },
              "carbohydrates": {
                "type": "number",
                "description":
                    "The amount of carbohydrates in the recipe (grams)."
              },
              "protein": {
                "type": "number",
                "description": "The amount of protein in the recipe (grams)."
              }
            },
            "additionalProperties": false,
            "required": ["calories", "fat", "carbohydrates", "protein"],
            "description": "Nutritional information for the recipe."
          },
          "tips": {
            "type": "array",
            "items": {"type": "string"},
            "description": "Optional cooking tips or recommendations."
          }
        },
        "required": [
          "title",
          "description",
          "duration",
          "ingredients",
          "instructions",
          "NutritionalInfo",
          "tips"
        ],
        "strict": true,
        "additionalProperties": false
      }
    },
  };

  PromptSettingsModel settings = PromptSettingsModel(
    systemPrompt: systemPrompt,
    userPrompt: userPrompt,
    returnFormat: returnFormat,
  );

  try {
    CompletionModel response = await ApiService.createCompletion(
        promptSetting: settings, max_completion_tokens: 16384);

    Map recipe = jsonDecode(response.message);
    FullRecipeModel recipeDetail = FullRecipeModel(
      title: recipe['title'],
      description: recipe['description'],
      duration: recipe["duration"],
      ingredients: List<String>.from(recipe["ingredients"]),
      instructions: List<String>.from(recipe["instructions"]),
      NutritionalInfo: NutriinfoModel(
        calories: recipe["NutritionalInfo"]["calories"],
        fat: recipe["NutritionalInfo"]["fat"],
        carbohydrates: recipe["NutritionalInfo"]["carbohydrates"],
        protein: recipe["NutritionalInfo"]["protein"],
      ),
      tips: List<String>.from(recipe["ingredients"]),
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecipeDetail(fullRecipe: recipeDetail),
      ),
    );
    print(recipeDetail);
    return recipeDetail;
  } catch (e) {
    print("Error $e");
    rethrow;
  }
}
