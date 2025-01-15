import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/recipe_app/screens/recipe_screen.dart';  // Import RecipeScreen
import 'package:recipeapp/widgets/recipes_list.dart';  // Import RecipesList
import 'package:recipeapp/widgets/searchbar.dart';  // Import SearchBarApp
import 'package:recipeapp/data/recipe_data.dart';  // Import RecipeData to access the hardcoded recipes

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() {
    return _RecipeState();
  }
}

class _RecipeState extends State<Recipes> {
  // Use the hardcoded recipes from RecipeData
  final List<Recipe> _registeredRecipes = RecipeData.registeredRecipes;

  // Function to toggle favorite status of a recipe
  void _toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
    });
  }

  // Function to delete a recipe
  void _deleteRecipe(Recipe recipe) {
    setState(() {
      _registeredRecipes.remove(recipe);
    });
  }

  // Navigate to RecipeScreen and pass the selected recipe
  void _navigateToRecipe(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => RecipeScreen(recipe: recipe), // Pass the selected recipe here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      body: Column(
        children: [
          SearchBarApp(recipes: _registeredRecipes),  // Pass the recipes to the SearchBarApp
          _registeredRecipes.isEmpty
              ? const Center(child: Text('No recipes available.'))  // Message when no recipes exist
              : RecipesList(
            recipes: _registeredRecipes,  // Pass the list of recipes
            onDeleteRecipe: _deleteRecipe,  // Pass the delete handler
            toggleFavorite: _toggleFavorite,  // Pass the toggle favorite handler
            onRecipeTap: _navigateToRecipe,  // Handle recipe selection
          ),
        ],
      ),
    );
  }
}
