import 'dart:convert';

import 'package:cooking_companion/models/completion_model.dart';
import 'package:cooking_companion/models/full_recipe_model.dart';
import 'package:cooking_companion/models/ingredient_model.dart';
import 'package:cooking_companion/models/nutri_info_model.dart';
import 'package:cooking_companion/models/prompt_settings_model.dart';
import 'package:cooking_companion/models/short_recipe_model.dart';
import 'package:cooking_companion/pages/recipe_detail.dart';
import 'package:cooking_companion/services/api_models.dart';
import 'package:cooking_companion/widgets/recipe_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RecipeOverview extends StatefulWidget {
  const RecipeOverview({super.key, required this.UserRecipeRequirements});

  final String UserRecipeRequirements;

  @override
  State<RecipeOverview> createState() => _RecipeOverviewState();
}

class _RecipeOverviewState extends State<RecipeOverview> {
  List<FullRecipeModel> recipes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Overview"),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 1, // Number of columns
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 5.0,
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return RecipePreviewCard(
            recipe: recipe,
            gotoRecipeDetails: () =>
                getRecipeDetails(context, recipes[index].description),
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
            "items": {
              "type": "object",
              "properties": {
                "name": {
                  "type": "string",
                  "description": "The name of the ingredient"
                },
                "amount": {
                  "type": "string",
                  "description":
                      "The amount of the ingredient. Prefer metric over imperial messurements"
                }
              }
            },
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
    FullRecipeModel recipe =
        await FullRecipeModel.createWithAPI(promptSetting: settings);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecipeDetail(fullRecipe: recipe),
      ),
    );

    return recipe;
  } catch (e) {
    print("Error $e");
    rethrow;
  }
}
