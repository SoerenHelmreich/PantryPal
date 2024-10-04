import 'package:cooking_companion/models/full_recipe_model.dart';
import 'package:cooking_companion/models/nutri_info_model.dart';
import 'package:cooking_companion/models/short_recipe_model.dart';
import 'package:cooking_companion/pages/recipe_detail.dart';
import 'package:flutter/material.dart';

class RecipePreviewCard extends StatelessWidget {
  const RecipePreviewCard(
      {super.key,
      required this.recipeSuggestion,
      required this.gotoRecipeDetails});

  final ShortRecipeModel recipeSuggestion;
  final Function gotoRecipeDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => gotoRecipeDetails(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          recipeSuggestion.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color:
                                Theme.of(context).primaryColor.withAlpha(50)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          child: Text(recipeSuggestion.duration,
                              style: const TextStyle()),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  recipeSuggestion.description,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
