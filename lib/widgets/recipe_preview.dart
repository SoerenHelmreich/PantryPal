import 'package:cooking_companion/models/short_recipe_model.dart';
import 'package:flutter/material.dart';

class RecipePreviewCard extends StatelessWidget {
  const RecipePreviewCard({super.key, required this.recipeSuggestion});

  final ShortRecipeModel recipeSuggestion;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              recipeSuggestion.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(recipeSuggestion.description),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Duration: ${recipeSuggestion.duration}"),
          ),
        ],
      ),
    );
  }
}
