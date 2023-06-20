import 'package:hive/hive.dart';
import '../models/recipe.dart';

class DatabaseService {
  static const String boxName = 'Recipes';

  Future<void> addRecipe(Recipe recipe) async {
    final box = await Hive.openBox(boxName);
    await box.add(recipe);
  }

  Future<List<Recipe>> getRecipe(Recipe recipe) async {
    final box = await Hive.openBox(boxName);
    return box.get(recipe.key).toList().cast<Recipe>();
  }

  Future<void> editRecipe(int key, Recipe recipe) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, recipe);
  }

  Future<void> deleteRecipe(Recipe recipe) async {
    final box = await Hive.openBox(boxName);
    box.delete(recipe.key);
  }
}
