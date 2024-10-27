import 'dart:convert';
import 'package:pantry_pal/pages/recipe_step.dart';
import 'package:pantry_pal/pages/sign_up_page_email.dart';
import 'package:pantry_pal/utils/constants.dart';
import 'package:pantry_pal/models/full_recipe_model.dart';
import 'package:pantry_pal/services/recipe_repository.dart';

import 'package:pantry_pal/models/ingredient_model.dart';
import 'package:pantry_pal/widgets/centerOnWeb.dart';
import 'package:pantry_pal/widgets/ingredient_card.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/widgets/nutrition_card.dart';
import 'package:simple_animated_button/elevated_layer_button.dart';
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
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: ElevatedLayerButton(
              onClick: () => Navigator.of(context).pop(),
              buttonHeight: 50,
              buttonWidth: 50,
              animationDuration: const Duration(milliseconds: 200),
              animationCurve: Curves.ease,
              topDecoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(60)),
              topLayerChild: const Icon(Icons.arrow_back),
              baseDecoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(60)),
            ),
          ),
          scrolledUnderElevation: 0.0,
          forceMaterialTransparency: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ElevatedLayerButton(
                onClick: () => saveToFavorites(),
                buttonHeight: 50,
                buttonWidth: 190,
                animationDuration: const Duration(milliseconds: 200),
                animationCurve: Curves.ease,
                topDecoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(60)),
                topLayerChild:
                    Text("Save to favorites", style: monoStyleButtonSmall),
                baseDecoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(60)),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.fullRecipe.title, style: monoStyleTitle),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32),
                    child: Text(
                      widget.fullRecipe.description,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NutritionCard(
                          nutrients: widget.fullRecipe.nutritionalInfo),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.fullRecipe.ingredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = widget.fullRecipe.ingredients[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: IngredientCard(
                            ingredient: Ingredient(
                                name: ingredient.name,
                                amount: ingredient.amount)),
                      );
                    },
                  ),
                  SizedBox(height: 80)
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: ElevatedLayerButton(
          onClick: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeStep(
                fullRecipe: widget.fullRecipe,
              ),
            ),
          ),
          buttonHeight: 70,
          buttonWidth: 240,
          animationDuration: const Duration(milliseconds: 200),
          animationCurve: Curves.ease,
          topDecoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(),
              borderRadius: BorderRadius.circular(20)),
          topLayerChild:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.local_dining),
            const SizedBox(width: 10),
            Text(
              "Start cooking",
              style: monoStyleButtonBig,
            ),
          ]),
          baseDecoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  void saveToFavorites() async {
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
            redirectPage: RecipeDetail(fullRecipe: widget.fullRecipe),
          ),
        ),
      );
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
  }
}
