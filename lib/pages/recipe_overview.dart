import 'package:cooking_companion/models/short_recipe_model.dart';
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
          );
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(
          1,
        ),
      ),
    );
  }
}

