import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/colors.dart';

class BigRecipeCard extends StatelessWidget {
  final Recipe recipe;

  const BigRecipeCard({required this.recipe, super.key});

  // Helper method to get the category color for different categories
  Color _getCategoryColor(Category category) {
    switch (category) {
      case Category.meat:
        return AppColors.meat;
      case Category.fish:
        return AppColors.fish;
      case Category.pasta:
        return AppColors.pasta;
      case Category.salad:
        return AppColors.salad;
      case Category.dessert:
        return AppColors.dessert;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Padding inside the card
      decoration: BoxDecoration(
        color: Colors.white, // White background for the card
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.1), // Light shadow effect
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SingleChildScrollView( // Makes the content scrollable vertically
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          children: [
            // Display Recipe Title with large font size and bold text
            Text(
              recipe.title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Center the title - doesn't work
            ),
            const SizedBox(height: 16),

            // Row with cooking time and category dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the elements
              children: [
                Row(
                  children: [
                    const Icon(Icons.timer, color: Colors.orange), // Timer icon
                    const SizedBox(width: 8),
                    Text('Cooking Time: ${recipe.cookingTime} min'),
                  ],
                ),
                // Category dropdown with background color based on category
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(recipe.category), // Dynamic background color
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        recipe.category.toString().split('.').last, // Display category name
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Ingredients section title
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(recipe.ingredients),
            const SizedBox(height: 16),

            // Instructions section title
            const Text(
              'Instructions:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(recipe.instructions),
          ],
        ),
      ),
    );
  }
}
