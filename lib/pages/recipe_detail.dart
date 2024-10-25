import 'dart:convert';
import 'package:pantry_pal/pages/sign_up_page_email.dart';
import 'package:pantry_pal/utils/constants.dart';
import 'package:pantry_pal/models/full_recipe_model.dart';
import 'package:pantry_pal/services/recipe_repository.dart';

import 'package:pantry_pal/models/ingredient_model.dart';
import 'package:pantry_pal/widgets/centerOnWeb.dart';
import 'package:pantry_pal/widgets/ingredient_card.dart';
import 'package:flutter/material.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final controller = ScrollController();

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key, required this.fullRecipe});
  final FullRecipeModel fullRecipe;

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  final supabase = Supabase.instance.client;
  bool recipeSaved = false;

  // Controllers
  late ScrollController _scrollController;

  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedContainer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.fullRecipe.title),
          scrolledUnderElevation: 0.0,
          actions: [
            IconButton(
              onPressed: () async {
                if (supabase.auth.currentUser != null) {
                  await RecipeRepository.createRecipe(widget.fullRecipe);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Recipe saved successfully!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  setState(() {
                    recipeSaved = true;
                  });
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpPage(
                              redirectPage: RecipeDetail(
                                  fullRecipe: widget.fullRecipe))));
                }
                try {} catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to save recipe: $e'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
                setState(() {
                  recipeSaved = false;
                });
              },
              icon: Icon(
                recipeSaved ? Icons.favorite : Icons.favorite_outline,
              ),
            ),
          ],
        ),
        body: DynMouseScroll(
          durationMS: 500,
          scrollSpeed: 3.5,
          animationCurve: Curves.easeOutQuart,
          builder: (context, controller, physics) => SingleChildScrollView(
            controller: controller,
            physics: physics,

            //controller: controller,
            // physics: physics,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.fullRecipe.description,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                Center(
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nutritional Information',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              'Calories: ${widget.fullRecipe.nutritionalInfo.calories}'),
                          Text(
                              'Fat: ${widget.fullRecipe.nutritionalInfo.fat}g'),
                          Text(
                              'Carbohydrates: ${widget.fullRecipe.nutritionalInfo.carbohydrates}g'),
                          Text(
                              'Protein: ${widget.fullRecipe.nutritionalInfo.protein}g'),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Ingredients',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.fullRecipe.ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = widget.fullRecipe.ingredients[index];
                    return IngredientCard(
                        ingredient: Ingredient(
                            name: ingredient.name, amount: ingredient.amount));
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Instructions',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.fullRecipe.instructions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(widget.fullRecipe.instructions[index]),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
