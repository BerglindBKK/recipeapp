import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/recipe_app/screens/add_recipes_screen.dart';
import 'package:recipeapp/recipe_app/screens/all_recipes_screen.dart';
import 'package:recipeapp/recipe_app/screens/favorites_screen.dart';
import 'package:recipeapp/recipe_app/screens/welcome_screen.dart';
import 'package:recipeapp/data/recipe_data.dart';

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  // Active screen to control which screen is currently displayed
  String activeScreen = 'welcome-screen';
  // Stores the previous screen to allow back navigation
  String previousScreen = '';
  // List to hold the registered recipes
  final List<Recipe> _registeredRecipes = RecipeData.registeredRecipes;

  // Function to add a new recipe to the registered list
  void _addRecipe(Recipe newRecipe) {
    setState(() {
      _registeredRecipes.add(newRecipe);  // Add the new recipe to the list
    });
  }

  // Function to switch between screens
  // Takes screen name and an optional recipe parameter for navigation
  void switchScreen(String screen, {Recipe? recipe}) {
    setState(() {
      previousScreen = activeScreen; // Save the current screen as previous screen
      activeScreen = screen; // Set the active screen to the new one
    });
  }

  @override
  Widget build(BuildContext context) {
    // Variable to hold the widget that represents the current screen
    Widget screenWidget;

    // Switch logic to choose which screen widget to display
    switch (activeScreen) {
      case 'all-recipes':
        screenWidget = AllRecipesScreen(
          onBack: () => switchScreen('welcome-screen'),  // Navigate back to welcome screen
          recipes: _registeredRecipes,  // Pass the list of registered recipes
          onNavigate: switchScreen,  // Function to handle navigation
          onRecipeTap: (recipe) => switchScreen('recipe-screen', recipe: recipe), // Navigate to individual recipe screen
        );
        break;

      case 'add-recipes':
        screenWidget = AddRecipesScreen(
          onBack: () {
            // Go back to the previous screen or default to welcome screen
            switchScreen(previousScreen.isNotEmpty ? previousScreen : 'welcome-screen');
          },
          onAddRecipe: _addRecipe,  // Pass the function to add a new recipe
          onNavigate: switchScreen,  // Function to handle navigation
        );
        break;

      case 'favorites':
        screenWidget = FavoritesScreen(
          onBack: () => switchScreen('all-recipes'),  // Go back to all recipes screen
        );
        break;

      default:
        screenWidget = WelcomeScreen(onNavigate: switchScreen);  // Default screen (Welcome)
    }

    return MaterialApp(
      theme: ThemeData.light(),  // Set light theme for the app
      darkTheme: ThemeData.dark(),  // Set dark theme for the app (for night mode)
      home: Scaffold(
        body: screenWidget,  // Display the current screen widget
      ),
    );
  }
}
