import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import '../../widgets/recipe_card.dart';

// FavoritesScreen allows the user to view and manage their favorite recipes
class FavoritesScreen extends StatefulWidget {
  final VoidCallback onBack; // Callback to go back to the previous screen

  const FavoritesScreen({
    super.key,
    required this.onBack,
  });

  @override
  // Use the public state class (no underscore)
  FavoritesScreenState createState() => FavoritesScreenState();
}

// Changed _FavoritesScreenState to FavoritesScreenState (public class)
class FavoritesScreenState extends State<FavoritesScreen> {
  // List to store favorite recipes in memory (this is temporary and could be updated later)
  final List<Recipe> _favoriteRecipes = [];

  // Add or remove a recipe from the favorites list
  void _toggleFavorite(Recipe recipe) {
    setState(() {
      if (_favoriteRecipes.contains(recipe)) {
        _favoriteRecipes.remove(recipe);  // Remove the recipe if it's already a favorite
      } else {
        _favoriteRecipes.add(recipe);  // Add the recipe to favorites if not already added
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
              // Back button to navigate to the previous screen
              IconButton(
                onPressed: widget.onBack,  // Trigger the back callback
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const Text(
                'Favorites',  // Title of the screen
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: _favoriteRecipes.isEmpty
      // Show a message when no recipes are added to favorites
          ? Center(
        child: Text(
          "No favorites yet.",  // Text shown when there are no favorite recipes
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      )
      // List view for displaying the favorite recipes
          : ListView.builder(
        itemCount: _favoriteRecipes.length,  // Total number of favorite recipes
        itemBuilder: (context, index) {
          final recipe = _favoriteRecipes[index];  // Get the recipe at the current index
          return RecipeCard(
            recipe: recipe,
            isPhotoOnLeft: index % 2 == 0,  // Alternate the position of the photo (left or right)
            isFavorite: true,  // Always true since we are on the Favorites screen
            toggleFavorite: () {
              _toggleFavorite(recipe);  // Toggle favorite status when tapped
            },
          );
        },
      ),
    );
  }
}
