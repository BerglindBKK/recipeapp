import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/recipe_app/screens/add_recipes_screen.dart';
import 'package:recipeapp/recipe_app/screens/all_recipes_screen.dart';
import 'package:recipeapp/recipe_app/screens/favorites_screen.dart';
import 'package:recipeapp/recipe_app/screens/welcome_screen.dart';
import 'package:recipeapp/data/recipe_data.dart';

// Main entry point for the recipe application.
// Manages navigation and state, allowing users to switch between different screens:
//   - 'welcome-screen' - 'all-recipes' - 'add-recipes'

// - The `switchScreen` method is used to switch between different screens, while the `_addRecipe` method adds new recipes to the list.
// - The app uses a `StatefulWidget` to manage state and handle screen changes dynamically.

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  // Active screen keeps track of which screen is currently active, with "welcome screen" as default since the app starts there
  String activeScreen = 'welcome-screen';

  // Maintains a list of registered recipes
  final List<Recipe> _registeredRecipes = RecipeData.registeredRecipes;

  // Function to add a new recipe to _registeredRecipes
  void _addRecipe(Recipe newRecipe) {
    setState(() {
      _registeredRecipes.add(newRecipe);
    });
  }

  // Function to switch between screens
  void switchScreen(String screen) {
    setState(() {
      activeScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    // "screenWidget" will hold the widget to display based on the current screen.
    Widget screenWidget;

    // Decides which screen to display based on "activeScreen"
    switch (activeScreen) {
    // If the current screen is 'all-recipes', display the AllRecipesScreen.
      case 'all-recipes':
        screenWidget = AllRecipesScreen(
          // onBack callback switches back to "welcome-screen"
          onBack: () => switchScreen('welcome-screen'),
          // Passes the list of registered recipes to the AllRecipesScreen to display.
          recipes: _registeredRecipes,
          // Pass the onNavigate callback to switch screens
          onNavigate: switchScreen,
        );
        break;
    // If the current screen is 'add-recipes', display the AddRecipesScreen.
      case 'add-recipes':
        screenWidget = AddRecipesScreen(
          // switches the screen back to the 'all-recipes' screen.
          onBack: () => switchScreen('all-recipes'),
          // Passes the '_addRecipe' function to add a new recipe.
          onAddRecipe: _addRecipe,
        );
        break;
      case 'favorites':
        screenWidget = FavoritesScreen(
          onBack: () => switchScreen('all-recipes'),
        );
      default:
        screenWidget = AllRecipesScreen(
          // onBack callback switches back to "welcome-screen"
          onBack: () => switchScreen('welcome-screen'),
          // Passes the list of registered recipes to the AllRecipesScreen to display.
          recipes: _registeredRecipes,
          // Pass the onNavigate callback to switch screens
          onNavigate: switchScreen,
        );
    }

    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: screenWidget,
      ),
    );
  }
}
