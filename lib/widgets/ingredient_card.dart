import 'package:cooking_companion/models/ingredient_model.dart';
import 'package:flutter/material.dart';

class IngredientCard extends StatelessWidget {
  const IngredientCard({super.key, required this.ingredient});
  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  ingredient.name,
                  style: TextStyle(fontSize: 20),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
              Text(
                ingredient.amount,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
