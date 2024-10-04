import 'package:cooking_companion/models/full_recipe_model.dart';
import 'package:cooking_companion/models/short_recipe_model.dart';
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
          Text(widget.fullRecipe.description),
          Expanded(
            child: ListView.builder(
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
          )
        ],
        //description: json['description'],
        //duration: json['duration'],
        //ingredients: List<String>.from(json['ingredients']),
        //instructions: List<String>.from(json['instructions']),
        //NutritionalInfo: NutriinfoModel.fromJson(json['NutritionalInfo']),
        //tips: List<String>.from(json['tips']),
      ),
    );
  }
}
