import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/recipes_list.dart';
import 'package:recipeapp/models/recipe.dart';

class AllRecipesScreen extends StatefulWidget {
  final List<Recipe> recipes;
  final VoidCallback onBack;
  final Function(String) onNavigate;
  final Function(Recipe) onRecipeTap;

  const AllRecipesScreen({
    super.key,
    required this.recipes,
    required this.onBack,
    required this.onNavigate,
    required this.onRecipeTap,
  });

  @override
  State<AllRecipesScreen> createState() => _AllRecipesScreenState();
}

class _AllRecipesScreenState extends State<AllRecipesScreen> {
  String query = "";  // Search query to filter recipes

  // Function to delete a recipe from the list and show a SnackBar
  void _deleteRecipe(Recipe recipe) {
    setState(() {
      widget.recipes.remove(recipe);  // Remove recipe from the list
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${recipe.title} deleted'),  // Show confirmation message
        duration: const Duration(seconds: 2),  // Duration for the snackbar
      ),
    );
  }

  // Toggle the 'isFavorite' status of a recipe
  void _toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;  // Change favorite status
    });
  }

  // Filter the recipes based on the search query
  List<Recipe> _getFilteredRecipes(String query) {
    return widget.recipes
        .where((recipe) =>
    recipe.title.toLowerCase().contains(query.toLowerCase()) ||  // Filter by title
        recipe.ingredients.toLowerCase().contains(query.toLowerCase()))  // Filter by ingredients
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;  // Get the current theme's color scheme

    return Scaffold(
      backgroundColor: Colors.white,  // Set background color
      appBar: AppBar(
        backgroundColor: Colors.white,  // Set AppBar background color
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 48.0, left: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: widget.onBack,  // Navigate back when the back button is pressed
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const Text(
                'All Recipes',  // Title of the screen
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Transparent overlay container
          Container(
            color: Colors.white.withOpacity(0.8),
          ),
          Column(
            children: [
              // Search bar for filtering recipes
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 8),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),  // Light background color
                    borderRadius: BorderRadius.circular(48),  // Rounded corners
                  ),
                  child: TextField(
                    onChanged: (String newQuery) {
                      setState(() {
                        query = newQuery;  // Update the search query when text changes
                      });
                    },
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Search recipes...',  // Placeholder text
                      hintStyle: TextStyle(color: Color(0xFFA5A5A5)),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Icon(
                          Icons.search,  // Search icon
                          color: Color(0xFFA5A5A5),
                        ),
                      ),
                      border: InputBorder.none,  // Remove border
                      contentPadding: EdgeInsets.symmetric(vertical: 15),  // Adjust padding
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RecipesList(
                  recipes: _getFilteredRecipes(query),  // Pass the filtered recipes to the list
                  onDeleteRecipe: _deleteRecipe,  // Pass the delete function
                  toggleFavorite: _toggleFavorite,  // Pass the toggle favorite function
                  onRecipeTap: widget.onRecipeTap,  // Pass the tap handler for recipes
                ),
              ),
            ],
          ),
        ],
      ),
      // Floating action button to add a new recipe
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: colorScheme.surface,  // Button background color
              foregroundColor: colorScheme.onSurface,  // Button text color
              elevation: 5.0,  // Button elevation for shadow effect
              hoverElevation: 10.0,  // Button hover elevation
              onPressed: () => widget.onNavigate('add-recipes'),  // Navigate to 'add-recipes' screen
              child: const Icon(
                Icons.add,
                color: Colors.black,  // Icon color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
