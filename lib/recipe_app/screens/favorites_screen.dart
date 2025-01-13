import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/recipe_app/screens/recipe_screen.dart';

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
  // List of favorite recipes -stored in memory
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
          padding: const EdgeInsets.only(top: 48.0, left: 16), // Adjust padding for proper positioning
          child: Row(
            children: [
              // Back button that calls the onBack function when pressed
              IconButton(
                onPressed: widget.onBack, // Goes back to the previous screen
                icon: const Icon(Icons.arrow_back_ios), // The icon for the back button
              ),
              // Title of the screen
              const Text(
                'All Recipes', // Title text
                style: TextStyle(fontSize: 24, color: Colors.black), // Style for the title text
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
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            leading: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () => _toggleFavorite(recipe),
            ),
            title: Text(recipe.title),
            subtitle: Text(recipe.category.name),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Recipe screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeScreen(recipe: recipe),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
