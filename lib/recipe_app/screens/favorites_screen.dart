import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/recipe_app/screens/recipe_screen.dart';

import '../../widgets/recipe_card.dart';

class FavoritesScreen extends StatefulWidget {
  final VoidCallback onBack; // Callback to go back to the previous screen

  const FavoritesScreen({
    super.key,
    required this.onBack,
  });

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // List of favorite recipes - stored in memory
  final List<Recipe> _favoriteRecipes = [];

  // Add or remove a recipe from the favorites list
  void _toggleFavorite(Recipe recipe) {
    setState(() {
      if (_favoriteRecipes.contains(recipe)) {
        _favoriteRecipes.remove(recipe); // Remove from favorites
      } else {
        _favoriteRecipes.add(recipe); // Add to favorites
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 48.0, left: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: widget.onBack,  // Go back to previous screen
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const Text(
                'Favorites',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: _favoriteRecipes.isEmpty
          ? Center(
        child: Text(
          "No favorites yet.",
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      )
          : ListView.builder(
        itemCount: _favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = _favoriteRecipes[index];
          return RecipeCard(
            recipe: recipe,
            isPhotoOnLeft: index % 2 == 0,  // Alternate photo position
            isFavorite: true,  // Since we're on the Favorites screen, the recipe is always a favorite
            toggleFavorite: () {
              _toggleFavorite(recipe);  // Toggle favorite status
            },
          );
        },
      ),
    );
  }
}
