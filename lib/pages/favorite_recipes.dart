import 'package:pantry_pal/models/full_recipe_model.dart';
import 'package:pantry_pal/pages/prompt_page.dart';
import 'package:pantry_pal/pages/recipe_detail.dart';
import 'package:pantry_pal/widgets/centerOnWeb.dart';
import 'package:pantry_pal/widgets/recipe_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/utils/constants.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteRecipes extends StatelessWidget {
  const FavoriteRecipes({super.key, required this.favoriteRecipes});

  final List<FullRecipeModel> favoriteRecipes;

  @override
  Widget build(BuildContext context) {
    return ConstrainedContainer(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
          scrolledUnderElevation: 0.0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Logged in user:"),
                        Text(supabase.auth.currentUser?.email ??
                            'No email available'),
                      ],
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        supabase.auth.signOut(scope: SignOutScope.local);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PromptPage()));
                      },
                      label: Text("Sign Out"),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Your favorite recipes",
              style: TextStyle(fontSize: 24),
            ),
            Expanded(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 1, // Number of columns
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 5.0,
                itemCount: favoriteRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = favoriteRecipes[index];
                  return RecipePreviewCard(
                    recipe: recipe,
                    gotoRecipeDetails: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RecipeDetail(fullRecipe: recipe)));
                    },
                  );
                },
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
