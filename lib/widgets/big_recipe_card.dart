import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/colors.dart';

class BigRecipeCard extends StatelessWidget {
  final Recipe recipe; // The recipe data to be displayed
  final bool isFavorite; // Whether the recipe is marked as a favorite
  final VoidCallback toggleFavorite; // Function to toggle the favorite status

  const BigRecipeCard({
    required this.recipe, // The recipe object passed in to display
    required this.isFavorite, // Whether the recipe is a favorite or not
    required this.toggleFavorite, // Function to toggle the favorite status
    super.key,
  });

  // Helper method to get the category color for different categories
  Color _getCategoryColor(Category category) {
    switch (category) {
      case Category.meat:
        return AppColors.meat; // Return the color for meat category
      case Category.fish:
        return AppColors.fish; // Return the color for fish category
      case Category.pasta:
        return AppColors.pasta; // Return the color for pasta category
      case Category.salad:
        return AppColors.salad; // Return the color for salad category
      case Category.dessert:
        return AppColors.dessert; // Return the color for dessert category
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0), // Padding inside the card for spacing
      decoration: BoxDecoration(
        color: Colors.white, // White background color for the card
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32), // Rounded corners at the top left
          topRight: Radius.circular(32), // Rounded corners at the top right
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.1), // Light shadow effect for depth
            blurRadius: 8, // The blurriness of the shadow
            spreadRadius: 2, // The spread of the shadow
          ),
        ],
      ),
      child: SingleChildScrollView( // Makes the content inside the card scrollable
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          children: [
            // Recipe title displayed with a large font size
            Text(
              recipe.title, // The title of the recipe
              style: const TextStyle(
                fontSize: 32, // Large font size for the title
                fontWeight: FontWeight.bold, // Bold text for emphasis
              ),
              textAlign: TextAlign.center, // Center the title text
            ),
            const SizedBox(height: 16), // Space between elements

            // Row to display cooking time and category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the items
              children: [
                Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.black87), // Timer icon
                    const SizedBox(width: 8), // Space between icon and text
                    Text('Cooking Time: ${recipe.cookingTime} min'), // Cooking time text
                  ],
                ),
                // Category container with dynamic background color based on category
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Padding around the category text
                  decoration: BoxDecoration(
                    color: _getCategoryColor(recipe.category), // Get color based on the category
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black87,
                        size: 16, // Icon for dropdown arrow
                      ),
                      const SizedBox(width: 4), // Space between icon and category text
                      Text(
                        recipe.category.toString().split('.').last, // Display category name by splitting enum
                        style: const TextStyle(color: Colors.black87), // Text color for category
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16), // Space between sections

            // Ingredients section header
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Bold text for ingredients title
            ),
            const SizedBox(height: 8), // Space between title and content
            Text(recipe.ingredients), // Ingredients text

            const SizedBox(height: 16), // Space before instructions

            // Instructions section header
            const Text(
              'Instructions:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Bold text for instructions title
            ),
            const SizedBox(height: 8), // Space between title and content
            Text(recipe.instructions), // Instructions text

            // Add your favorite button here (not shown in this snippet)
          ],
        ),
      ),
    );
  }
}
