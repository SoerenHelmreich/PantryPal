import 'package:pantry_pal/models/full_recipe_model.dart';
import 'package:pantry_pal/pages/favorite_recipes.dart';
import 'package:pantry_pal/pages/recipe_detail.dart';
import 'package:pantry_pal/pages/sign_up_page_email.dart';
import 'package:pantry_pal/services/recipe_repository.dart';
import 'package:pantry_pal/utils/constants.dart';
import 'package:pantry_pal/widgets/centerOnWeb.dart';

import 'package:supabase_flutter/supabase_flutter.dart'; // Import the supabase_flutter package
import 'package:pantry_pal/widgets/recipe_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PromptPage extends StatefulWidget {
  const PromptPage({super.key});

  @override
  State<PromptPage> createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  final InputController = TextEditingController();

  List<FullRecipeModel> recipes = [];
  bool isLoading = false;
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return ConstrainedContainer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pantry Pal"),
          scrolledUnderElevation: 0.0,
          actions: [
            IconButton.filledTonal(
                onPressed: () async {
                  final List<FullRecipeModel> favoriteRecipes =
                      await RecipeRepository.readAllRecipes();
                  //Check if user is logged in
                  if (supabase.auth.currentUser != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavoriteRecipes(
                                favoriteRecipes: favoriteRecipes)));
                  }
                  //Bring user to Login / Signup page
                  //Then redirect to Favorites
                  else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpPage(
                                  redirectPage: FavoriteRecipes(
                                      favoriteRecipes: favoriteRecipes),
                                )));
                  }
                },
                icon: const Icon(Icons.favorite))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: InputController,
                autocorrect: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "What do you have in your pantry?",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: FloatingActionButton.extended(
                  elevation: 5,
                  onPressed: () async {
                    recipes = [];
                    setState(() {
                      recipes;
                    });

                    //Create 4 recipe suggestions
                    for (var i = 0; i < 4; i++) {
                      String titles =
                          recipes.map((recipe) => recipe.title).join(", ");
                      FullRecipeModel recipe =
                          await FullRecipeModel.createWithAPI(
                        userPrompt:
                            "The user has: ${InputController.text}, you have already recommended $titles",
                      );
                      recipes.add(recipe);
                      setState(() {
                        recipes;
                      });
                    }
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  label: const Text("Generate Recipes"),
                  icon: const Icon(Icons.auto_awesome),
                ),
              ),
              Expanded(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 1, // Number of columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 5.0,
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return RecipePreviewCard(
                        recipe: recipe,
                        gotoRecipeDetails: () async {
                          await recipe.fillRecipeDetails(
                              userPrompt:
                                  "Title: ${recipe.title}. Description: ${recipe.description}");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeDetail(fullRecipe: recipe)));
                        });
                  },
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget getLoadingSpinner() {
  return Container(
    child: Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.black,
        size: 30,
      ),
    ),
  );
}
