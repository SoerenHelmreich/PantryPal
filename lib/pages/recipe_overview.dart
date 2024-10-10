import 'package:cooking_companion/models/full_recipe_model.dart';
import 'package:cooking_companion/pages/recipe_detail.dart';
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
              gotoRecipeDetails: () {
                print("Hello World");
              });
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(
          1,
        ),
      ),
    );
  }
}
