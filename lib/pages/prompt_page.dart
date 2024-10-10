import 'dart:convert';
import 'package:cooking_companion/models/completion_model.dart';
import 'package:cooking_companion/models/full_recipe_model.dart';
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

  List<FullRecipeModel> recipes = [];
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
            Center(
              child: FloatingActionButton.extended(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecipeOverview(
                          UserRecipeRequirements: InputController.text),
                    ),
                  );
                },
                label: const Text("Generate Recipes"),
                icon: const Icon(Icons.auto_awesome),
              ),
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

