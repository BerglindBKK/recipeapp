import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/recipe_app/screens/recipe_screen.dart'; // Import RecipeScreen
import 'package:recipeapp/widgets/recipes_list.dart';  // Import RecipesList
import 'package:recipeapp/widgets/searchbar.dart';  // Import SearchBarApp

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
      title: 'Rice Crispies Cookies',
      ingredients: 'Rice crispies, syrup',
      instructions: 'Mix and cool',
      cookingTime: '40 min',
      category: Category.dessert,
      imagePath: '', // Add image path if available
      photoUrl: '', // Add a URL if available
    ),
    Recipe(
      title: 'Pasta Bolognese',
      ingredients: 'Pasta, meat, tomato sauce',
      instructions: 'Cook pasta, prepare sauce',
      cookingTime: '30 min',
      category: Category.pasta,
      imagePath: '',
      photoUrl: '',
    ),
    // More recipes can be added here
  ];

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
          SearchBarApp(recipes: _registeredRecipes),
          _registeredRecipes.isEmpty
              ? const Center(child: Text('No recipes available.'))
              : RecipesList(
            recipes: _registeredRecipes,
            onDeleteRecipe: _deleteRecipe, // Pass the delete handler
            toggleFavorite: _toggleFavorite, // Pass the toggle favorite handler
            onRecipeTap: _navigateToRecipe, // Handle recipe selection
          ),
        ],
      ),
    );
  }
}
