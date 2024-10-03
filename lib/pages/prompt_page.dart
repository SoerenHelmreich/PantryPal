import 'dart:convert';
import 'package:cooking_companion/models/completion_model.dart';
import 'package:cooking_companion/models/prompt_settings_model.dart';
import 'package:cooking_companion/models/short_recipe_model.dart';
import 'package:cooking_companion/pages/recipe_overview.dart';
import 'package:cooking_companion/services/api_models.dart';
import 'package:cooking_companion/widgets/recipe_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PromptPage extends StatefulWidget {
  const PromptPage({super.key});

  @override
  State<PromptPage> createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  var InputController = TextEditingController();

  List<ShortRecipeModel> recipesSuggestions = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantry Pal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: InputController,
              autocorrect: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.local_grocery_store_outlined),
                hintText: "What do you have in your pantry?",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            SizedBox(height: 40),
            //When function is running, show LoadingSpinner instead of button
            isLoading
                ? getLoadingSpinner()
                : FloatingActionButton.extended(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      recipesSuggestions = await getRecipesSuggestions(
                              context, InputController.text)
                          .then((result) {
                        setState(() {
                          isLoading = false;
                        });
                        return result;
                      });
                    },
                    label: const Text("Generate Recipes"),
                    icon: const Icon(Icons.auto_awesome),
                  ),
          ],
        ),
      ),
    );
  }
}

Widget getLoadingSpinner() {
  return new Container(
    child: Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.black,
        size: 30,
      ),
    ),
  );
}

Future<List<ShortRecipeModel>> getRecipesSuggestions(
    BuildContext context, String userPrompt) async {
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

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecipeOverview(recipeOverview: recipeSuggestions),
      ),
    );

    return recipeSuggestions;
  } catch (e) {
    print("Error $e");
    rethrow;
  }
}
