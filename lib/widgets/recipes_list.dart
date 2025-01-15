import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/widgets/recipe_card.dart';

class RecipesList extends StatelessWidget {
  const RecipesList({
    super.key,
    required this.recipes,  // The list of recipes to display
    required this.onDeleteRecipe,  // Function to handle recipe deletion
    required this.toggleFavorite,  // Function to toggle the favorite status
    required this.onRecipeTap,  // Function to navigate to a detailed recipe screen
  });

  final List<Recipe> recipes;  // The list of recipes passed to this widget
  final Function(Recipe) onDeleteRecipe;  // Function to delete a recipe
  final Function(Recipe) toggleFavorite;  // Function to toggle the favorite status of a recipe
  final Function(Recipe) onRecipeTap;  // Function to navigate to the recipe's detailed screen

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),  // Adds padding to the top of the list
      child: ListView.separated(
        itemCount: recipes.isEmpty ? 1 : recipes.length,  // If no recipes, show a message; otherwise, show recipes
        itemBuilder: (ctx, index) {
          if (recipes.isEmpty) {
            // If the recipe list is empty, show a message
            return const Center(child: Text('No recipes available.'));
          }

          // Wrap each recipe in a Dismissible widget to enable swipe-to-delete functionality
          return Dismissible(
            key: ValueKey(recipes[index].id),  // Unique key for each recipe (based on its ID)
            onDismissed: (direction) {
              // Call the delete function when the item is swiped away
              onDeleteRecipe(recipes[index]);

              // Show a snack bar message confirming the deletion
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${recipes[index].title} deleted'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            background: Container(
              color: Colors.red.withValues(alpha: 0.75),  // Background color when swiped (red)
              alignment: Alignment.centerLeft,  // Align the delete icon to the left
              padding: const EdgeInsets.symmetric(horizontal: 10),  // Padding for the delete icon
              child: const Icon(Icons.delete, color: Colors.white),  // Delete icon
            ),
            child: GestureDetector(
              // On tap, trigger the recipe tap function
              onTap: () => onRecipeTap(recipes[index]),
              child: RecipeCard(
                recipe: recipes[index],  // Pass the current recipe to the RecipeCard widget
                isPhotoOnLeft: index % 2 == 0,  // Determine if the photo should be on the left or right (alternating)
                isFavorite: recipes[index].isFavorite,  // Pass whether the recipe is a favorite or not
                toggleFavorite: () => toggleFavorite(recipes[index]),  // Toggle the favorite status
              ),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          // Add spacing between the recipe cards
          return const SizedBox(height: 30);  // Add a 30-pixel space between items
        },
      ),
    );
  }
}
