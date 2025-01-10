import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/data/recipe_data.dart';
// import 'package:recipeapp/colors.dart'; // Import the colors file
import 'package:recipeapp/widgets/big_recipe_card.dart'; // Import the BigRecipeCard widget
// import 'package:recipeapp/recipe_app/screens/all_recipes_screen.dart'; // Import AllRecipesScreen

class RecipeScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeScreen({required this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Photo Section (this is the background image behind the recipe card)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: recipe.imagePath != null && recipe.imagePath!.isNotEmpty // Check if imagePath exists and is not empty
            ? Image.asset(
              recipe.imagePath!,
              width: double.infinity,
              height: 300, // Adjust the height of the photo
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);  // Show error if image fails to load
              },
            )
            // If imagePath doesn't exist, try photoUrl (for network images):
            : recipe.photoUrl != null && recipe.photoUrl!.isNotEmpty
                ? Image.network(
              recipe.photoUrl!,
              width: double.infinity,
              height: 300, // Adjust the height of the photo
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);  // Show error if image fails to load
              },
            )
            // If neither imagePath nor photoUrl exists, use default image
            : Image.asset(
              getCategoryDefaultImage(recipe.category),
              width: double.infinity,
              height: 300, // Adjust the height of the photo
              fit: BoxFit.cover,
            ),
          ),

          // Recipe Card Section (this is the card with recipe details)
          Positioned(
            top: 250, // Position the recipe card below the photo (it will overlap)
            left: 0,
            right: 0,
            bottom: 0, // Ensure it takes the remaining space
            child: Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(48), // Rounded corners for the top
                  topRight: Radius.circular(48),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: BigRecipeCard(recipe: recipe), // Use BigRecipeCard widget
            ),
          ),
        ],
      ),

      // Floating Action Buttons
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Stack(
        children: [
          // Back Button (to navigate back to AllRecipesScreen)
          Positioned(
            top: 16,
            left: 4, // Ensure padding on the left side
            child: Opacity(
              opacity: 0.75, // Set the opacity for the entire button (0.0 to 1.0)
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to AllRecipesScreen
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),

          // Favorite Button (Heart button)
          Positioned(
            top: 16,
            right: 32, // Ensure padding on the right side
            child: Opacity(
              opacity: 0.75, // Set the opacity for the entire button (0.0 to 1.0)
              child: FloatingActionButton(
                onPressed: () {
                  // Your favorite action goes here
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.favorite, color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
