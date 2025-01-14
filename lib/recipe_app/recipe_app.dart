import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/recipe_app/screens/add_recipes_screen.dart';
import 'package:recipeapp/recipe_app/screens/all_recipes_screen.dart';
import 'package:recipeapp/recipe_app/screens/favorites_screen.dart';
import 'package:recipeapp/recipe_app/screens/recipe_screen.dart';
import 'package:recipeapp/recipe_app/screens/welcome_screen.dart';
import 'package:recipeapp/data/recipe_data.dart';

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  String activeScreen = 'welcome-screen';
  String previousScreen = '';
  final List<Recipe> _registeredRecipes = RecipeData.registeredRecipes;

  void _addRecipe(Recipe newRecipe) {
    setState(() {
      _registeredRecipes.add(newRecipe);
    });
  }

  void switchScreen(String screen, {Recipe? recipe}) {
    setState(() {
      previousScreen = activeScreen;
      activeScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget;

    switch (activeScreen) {
      case 'all-recipes':
        screenWidget = AllRecipesScreen(
          onBack: () => switchScreen('welcome-screen'),
          recipes: _registeredRecipes,
          onNavigate: switchScreen,
          onRecipeTap: (recipe) => switchScreen('recipe-screen', recipe: recipe),
        );
        break;

      case 'add-recipes':
        screenWidget = AddRecipesScreen(
          onBack: () {
            switchScreen(previousScreen.isNotEmpty ? previousScreen : 'welcome-screen');
          },
          onAddRecipe: _addRecipe,
          onNavigate: switchScreen,
        );
        break;

      case 'favorites':
        screenWidget = FavoritesScreen(
          onBack: () => switchScreen('all-recipes'),
        );
        break;

      default:
        screenWidget = WelcomeScreen(onNavigate: switchScreen);
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
