import 'dart:convert';
import 'package:cooking_companion/models/completion_model.dart';
import 'package:cooking_companion/models/prompt_settings_model.dart';
import 'package:cooking_companion/models/short_recipe_model.dart';
import 'package:cooking_companion/services/api_models.dart';
import 'package:cooking_companion/widgets/recipe_preview.dart';
import 'package:flutter/material.dart';

class PromptPage extends StatefulWidget {
  const PromptPage({super.key});

  @override
  State<PromptPage> createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  var InputController = TextEditingController();

  List<ShortRecipeModel> recipesSuggestions = [
    ShortRecipeModel(
        title: "Hello World",
        description: "This is a nice description",
        duration: "30 minutes"),
    ShortRecipeModel(
        title: "Hello World 2",
        description: "This is a niceeeeee description",
        duration: "60 minutes")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello World"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: InputController,
            autocorrect: true,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: recipesSuggestions.length,
              itemBuilder: (context, index) {
                final recipe = recipesSuggestions[index];
                return RecipePreviewCard(
                  recipeSuggestion: recipe,
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        recipesSuggestions = await getRecipesSuggestions();
        setState(() {}); // Update the UI after fetching the suggestions
      }),
    );
  }
}

Future<List<ShortRecipeModel>> getRecipesSuggestions() async {
  String systemPrompt =
      "You are a professional chef. The user wants to cook something, but only has a few ingredients available. You recommend a good recipe to the user that they can cook using the ingredients they have, but feel free to add other nescessary ingredients the user might have to buy. The user will also add optional requirements, such as 'vegetarian', 'quick' or 'breakfast'. Please keep those requirements in mind when recommending recipe ideas. Please return four possible recipe ideas with a title, a short description and an estimated duration. Please return your answer in a json object that can be displayed in a web application.";

  Object returnFormat = {
    "type": "json_schema",
    "json_schema": {
      "name": "shortRecipe",
      "schema": {
        "type": "object",
        "properties": {
          "recipes": {
            "type": "array",
            "items": {
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
              },
            },
            "required": ["recipes"],
          },
          "additionalProperties": false
        },
        "strict": true
      }
    }
  };

  String userPrompt =
      "I have potatoes, cheese and chilli. What vegetarian meal can I cook?";

  PromptSettingsModel settings = PromptSettingsModel(
    systemPrompt: systemPrompt,
    userPrompt: userPrompt,
    returnFormat: returnFormat,
  );

  try {
    CompletionModel response =
        await ApiService.createCompletion(promptSetting: settings);

    Map jsonResponse = jsonDecode(response.message);

    List<ShortRecipeModel> recipeSuggestions = [];

    for (var recipe in jsonResponse['recipes']) {
      recipeSuggestions.add(
        ShortRecipeModel(
          title: recipe['title'],
          description: recipe['description'],
          duration: recipe['duration'],
        ),
      );
    }
    return recipeSuggestions;
  } catch (e) {
    print("Error $e");
    rethrow;
  }
}
