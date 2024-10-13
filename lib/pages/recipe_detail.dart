import 'package:cooking_companion/models/full_recipe_model.dart';
import 'package:cooking_companion/models/ingredient_model.dart';
import 'package:cooking_companion/widgets/ingredient_card.dart';
import 'package:flutter/material.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key, required this.fullRecipe});
  final FullRecipeModel fullRecipe;

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fullRecipe.title),
      ),
      body: DynMouseScroll(
        builder: (context, controller, physics) => SingleChildScrollView(
          controller: controller,
          physics: physics,
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
                        Text('Fat: ${widget.fullRecipe.nutritionalInfo.fat}g'),
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
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
    );
  }
}
