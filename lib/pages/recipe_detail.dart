import 'package:cooking_companion/models/full_recipe_model.dart';
import 'package:cooking_companion/models/ingredient_model.dart';
import 'package:cooking_companion/models/short_recipe_model.dart';
import 'package:cooking_companion/widgets/ingredient_card.dart';
import 'package:cooking_companion/widgets/recipe_preview_card.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return IngredientCard(
                    ingredient: Ingredient(name: "Cheese", amount: "200 gr"));
              }),
        ],

        //description: json['description'],
        //duration: json['duration'],
        //ingredients: List<String>.from(json['ingredients']),
        //instructions: List<String>.from(json['instructions']),
        //NutritionalInfo: NutriinfoModel.fromJson(json['NutritionalInfo']),
        //tips: List<String>.from(json['tips']),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Start cooking!"),
        icon: Icon(Icons.restaurant_menu),
      ),
    );
  }
}
