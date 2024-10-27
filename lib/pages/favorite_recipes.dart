import 'package:pantry_pal/models/full_recipe_model.dart';
import 'package:pantry_pal/pages/prompt_page.dart';
import 'package:pantry_pal/pages/recipe_detail.dart';
import 'package:pantry_pal/widgets/centerOnWeb.dart';
import 'package:pantry_pal/widgets/recipe_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/utils/constants.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simple_animated_button/elevated_layer_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteRecipes extends StatelessWidget {
  const FavoriteRecipes({super.key, required this.favoriteRecipes});

  final List<FullRecipeModel> favoriteRecipes;

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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ElevatedLayerButton(
                onClick: () {
                  supabase.auth.signOut(scope: SignOutScope.local);
                  Navigator.popUntil(context, (route) => route.isFirst
                      //ModalRoute.withName(PromptPage.routeName)
                      );
                },
                buttonHeight: 50,
                buttonWidth: 120,
                animationDuration: const Duration(milliseconds: 200),
                animationCurve: Curves.ease,
                topDecoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(60)),
                topLayerChild: Text("Sign out", style: monoStyleButtonSmall),
                baseDecoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(60)),
              ),
            ),
          ],
          forceMaterialTransparency: true,
          scrolledUnderElevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Text("Your favorites", style: monoStyleTitle),
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
      ),
    );
  }
}
