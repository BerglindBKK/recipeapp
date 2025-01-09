import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/widgets/searchbar.dart';  // Import SearchBarApp
import 'package:recipeapp/widgets/recipes_list.dart';
import 'package:recipeapp/recipe_app/screens/add_recipes_screen.dart';

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() {
    return _RecipeState();
  }
}

class _RecipeState extends State<Recipes> {
  // Sample list of recipes
  final List<Recipe> _registeredRecipes = [
    Recipe(
      title: 'Rice crispies cookies',
      ingredients: 'rice crispies, syrup',
      instructions: 'Mix and cool',
      cookingTime: '40 min',
      category: Category.dessert,
    ),
    Recipe(
      title: 'Pasta Bolognese',
      ingredients: 'Pasta, meat, tomato sauce',
      instructions: 'Cook pasta, prepare sauce',
      cookingTime: '30 min',
      category: Category.pasta,
    ),
  ];

  void _addRecipe(Recipe recipe) {
    setState(() {
      _registeredRecipes.add(recipe);
    });
  }

  void _deleteRecipe(Recipe recipe) {
    setState(() {
      _registeredRecipes.remove(recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      body: Column(
        children: [
          // Add the SearchBarApp widget here, passing the list of recipes
          SearchBarApp(recipes: _registeredRecipes), // Pass the recipes list to SearchBarApp

          // Display recipes
          _registeredRecipes.isEmpty
              ? const Center(child: Text('No recipes available.'))
              : RecipesList(
            recipes: _registeredRecipes,
            onDeleteRecipe: _deleteRecipe,  // Pass delete handler
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Add Recipe screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => AddRecipesScreen(
                onBack: () {
                  Navigator.pop(ctx);  // Go back to the previous screen
                },
                onAddRecipe: _addRecipe,
                //title: 'Add Recipe',
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
