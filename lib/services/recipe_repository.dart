import 'package:cooking_companion/models/full_recipe_model.dart';
import 'package:cooking_companion/utils/constants.dart';

class RecipeRepository {
  //Create
  static Future<dynamic> createRecipe(FullRecipeModel recipe) async {
    if (supabase.auth.currentUser != null) {
      final response = await supabase.from('RecipeFavorites').insert({
        'recipe': recipe.toJson(),
        'user_id': supabase.auth.currentUser!.id
      }).select();
      return response;
    } else {
      // TODO: Handle the case where the user is not authenticated
      throw Error();
    }
  }

  //Read All
  static Future<List<FullRecipeModel>> readAllRecipes() async {
    final response = await supabase.from('RecipeFavorites').select('*');
    List<FullRecipeModel> recipes = (response as List)
        .map((recipeData) => FullRecipeModel.fromJson(recipeData['recipe']))
        .toList();
    return recipes;
  }

  //Read
  static Future<dynamic> readRecipe(int id) async {
    final recipes =
        await supabase.from('RecipeFavorites').select().eq('id', id);
    print(recipes);
    return recipes;
  }

  //Update
  //Does not work yet
  static Future<dynamic> updateRecipes(
      int recipeId, FullRecipeModel recipe) async {
    Object recipeObject = recipe.toJson();

    try {
      List<Map<String, dynamic>> response = await supabase
          .from('RecipeFavorites')
          .update({'recipe': recipeObject})
          .eq('id', recipeId)
          .select();
      print(response);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //Delete
  static Future<void> deleteRecipes(int recipeId) async {
    final response =
        await supabase.from('RecipeFavorites').delete().eq('id', recipeId);
    print(response);
  }
}
