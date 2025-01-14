import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/recipes_list.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/recipe_app/screens/favorites_screen.dart';

class AllRecipesScreen extends StatefulWidget {
  final List<Recipe> recipes; // List of recipes passed from previous screen
  final VoidCallback onBack; // Callback to go back to the previous screen
  final Function(String) onNavigate; // Callback to switch between screens

  const AllRecipesScreen({
    super.key,
    required this.recipes, // List of recipes
    required this.onBack,   // Callback function for the back action
    required this.onNavigate, // Function to navigate to different screens
  });

  @override
  State<AllRecipesScreen> createState() => _AllRecipesScreenState(); // Creates the state for this screen
}

class _AllRecipesScreenState extends State<AllRecipesScreen> {
  String query = "";  // Variable to store the search query entered by the user

  // Function to delete a recipe when the delete button is pressed
  void _deleteRecipe(Recipe recipe) {
    setState(() {
      widget.recipes.remove(recipe);  // Remove the selected recipe from the list
    });

    // Show a SnackBar with a message indicating the recipe was deleted
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${recipe.title} deleted'),  // Show the title of the deleted recipe
        duration: const Duration(seconds: 2), // SnackBar duration of 2 seconds
      ),
    );
  }

  // Function to filter the recipes based on the search query
  List<Recipe> _getFilteredRecipes(String query) {
    // Use the `where` method to filter the recipes list by title or ingredients
    return widget.recipes
        .where((recipe) =>
    recipe.title.toLowerCase().contains(query.toLowerCase()) ||  // Check if the title matches the query
        recipe.ingredients.toLowerCase().contains(query.toLowerCase())) // Or if the ingredients match the query
        .toList();  // Convert the filtered recipes to a list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar at the top of the screen
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

      // Body of the screen
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/recipe_app_landing.jpg'),
                fit: BoxFit.cover, // Image covers the entire screen
              ),
            ),
          ),
// White overlay with opacity
          Container(
            color: Colors.white.withValues(alpha:0.8),  // White overlay with opacity
          ),
          Column(
            children: [
            // Search bar that allows the user to search for recipes
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 8),  // Padding for the search bar
              child: Container(
                width: double.infinity,  // Make the search bar the same width as recipe cards
                height: 55,  // Set height of the search bar
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),  // Light grey background
                  borderRadius: BorderRadius.circular(48),  // Rounded corners
                ),
                child: TextField(
                  onChanged: (String newQuery) {
                    setState(() {
                      query = newQuery;  // Update the query as the user types
                    });
                  },
                  textAlign: TextAlign.center,  // Center the text and placeholder inside the field
                  decoration: const InputDecoration(
                    hintText: 'Search recipes...',  // Placeholder text in the search field
                    hintStyle: TextStyle(color: Color(0xFFA5A5A5)),  // Set the color of the placeholder text
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 12.0),  // Adjust icon padding so it stays centered
                      child: Icon(
                        Icons.search,  // Search icon
                        color: Color(0xFFA5A5A5),  // Set the color of the icon
                      ),
                    ),
                    border: InputBorder.none,  // Remove the default border
                    contentPadding: EdgeInsets.symmetric(vertical: 15),  // Center the content vertically
                  ),
                ),
              ),
            ),

            // List of recipes that are filtered based on the search query
            Expanded(
              child: RecipesList(
                // Pass the filtered list of recipes to the RecipesList widget
                recipes: _getFilteredRecipes(query),  // Use the filtered list of recipes
                onDeleteRecipe: _deleteRecipe, // Pass the function to delete a recipe
              ),
            ),
          ],
        ),
      ]
      ),

      // Floating Action Button to navigate to Add Recipes Screen and FavoritesScreen
      floatingActionButton: Stack(
        children: [
          // FAB for Add Recipe
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              elevation: 5.0,
              onPressed: () => widget.onNavigate('add-recipes'), // Existing navigation logic
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),

          // FAB for Favorites
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              elevation: 5.0,
              onPressed: () {
                widget.onNavigate('favorites'); // Trigger the navigation to favorites screen
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.favorite,  // Heart icon for favorites
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
