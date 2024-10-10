import 'package:cooking_companion/models/full_recipe_model.dart';
import 'package:cooking_companion/pages/recipe_detail.dart';

import 'package:cooking_companion/widgets/recipe_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PromptPage extends StatefulWidget {
  const PromptPage({super.key});

  @override
  State<PromptPage> createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  var InputController = TextEditingController();

  List<FullRecipeModel> recipes = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantry Pal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: InputController,
              autocorrect: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.local_grocery_store_outlined),
                hintText: "What do you have in your pantry?",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            SizedBox(height: 40),
            //When function is running, show LoadingSpinner instead of button
            Center(
              child: FloatingActionButton.extended(
                elevation: 5,
                onPressed: () async {
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
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getLoadingSpinner() {
  return new Container(
    child: Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.black,
        size: 30,
      ),
    ),
  );
}
