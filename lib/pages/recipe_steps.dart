import 'package:cooking_companion/models/full_recipe_model.dart';
import 'package:flutter/material.dart';

class RecipeSteps extends StatelessWidget {
  const RecipeSteps({super.key, required this.fullRecipe});
  final FullRecipeModel fullRecipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fullRecipe.title),
      ),
      body: Column(
        children: [
          Text(fullRecipe.description),
          Expanded(
            child: ListView.builder(
              itemCount: fullRecipe.instructions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(fullRecipe.instructions[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
