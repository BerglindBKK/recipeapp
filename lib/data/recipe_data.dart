//recipe data stored in "registered expenses" list
//two hardcoded dummy cases
import 'package:recipeapp/models/recipe.dart';

class RecipeData {
  static final List<Recipe> registeredRecipes = [
    Recipe(
        title: 'Rice crispies kökur',
        ingredients: 'rice crispies, syrup',
        instructions: 'mix and cool',
        cookingTime: '40min',
        category: Category.dessert,
        imagePath: 'assets/images/raekjur.jpg'
    ),
    Recipe(
      title: 'Rblabla',
      ingredients: 'sdfgsdf',
      instructions: 'sgfd',
      cookingTime: '10min',
      category: Category.pasta,
    ),
  ];
}
