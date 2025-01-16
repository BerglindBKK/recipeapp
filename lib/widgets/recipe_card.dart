import 'package:flutter/material.dart';
import 'package:recipeapp/data/recipe_data.dart';
import 'package:recipeapp/models/recipe.dart';  // Import Recipe model to manage recipe data
import 'package:recipeapp/colors.dart';  // Import AppColors to manage category colors
import 'package:recipeapp/recipe_app/screens/recipe_screen.dart';  // Import RecipeScreen to navigate to recipe details screen

class RecipeCard extends StatelessWidget {
  final Recipe recipe;  // Recipe object that holds all information about the recipe
  final bool isPhotoOnLeft;  // Flag to determine if the photo should appear on the left side
  final bool isFavorite; // Flag to track whether the recipe is marked as a favorite
  final VoidCallback toggleFavorite; // Function to toggle the favorite status of the recipe

  const RecipeCard({
    required this.recipe,
    required this.isPhotoOnLeft,
    required this.isFavorite,  // Accept isFavorite to track if the recipe is a favorite
    required this.toggleFavorite,  // Accept toggleFavorite to toggle the favorite status
    super.key
  });

  // This function returns the category color based on the recipe's category (meat, fish, etc.)
  Color _getCategoryColor(Category category) {
    switch (category) {
      case Category.meat:
        return AppColors.meat;  // Color for meat category
      case Category.fish:
        return AppColors.fish;  // Color for fish category
      case Category.pasta:
        return AppColors.pasta;  // Color for pasta category
      case Category.salad:
        return AppColors.salad;  // Color for salad category
      case Category.dessert:
        return AppColors.dessert;  // Color for dessert category
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to RecipeScreen when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeScreen(recipe: recipe),  // Pass the selected recipe to RecipeScreen
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10),  // Padding around the card
        child: SizedBox(
          height: 110,  // Set height of the card
          child: Card(
            color: _getCategoryColor(recipe.category),  // Set the background color based on category
            elevation: 2,  // Elevation for a subtle shadow effect
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48),  // Rounded corners for the card
            ),
            child: Stack(  // Stack to layer the elements in the card
              clipBehavior: Clip.none,  // Allow the image to overflow outside the card
              children: [
                Positioned(
                  top: 0,
                  left: isPhotoOnLeft ? 125 : 15,  // Adjust the position of text depending on the photo position
                  right: isPhotoOnLeft ? 15 : 135,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),  // Padding inside the text area
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,  // Align text to the left
                      children: [
                        Text(
                          recipe.title,  // Display the recipe title
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF4E4D4D),  // Set the text color
                            fontSize: 24,  // Set the font size for the title
                            fontWeight: FontWeight.bold,  // Make the title bold
                            height: 1,  // Line height
                          ) ?? const TextStyle(
                            color: Color(0xFF4E4D4D),
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 8),  // Add spacing between title and other text
                        Row(
                          children: [
                            const Icon(Icons.timer, color: Color(0xFF4E4D4D), size:18,),  // Timer icon before cooking time
                            const SizedBox(width: 4),  // Space between icon and text
                            Text(
                              ' ${recipe.cookingTime} min',  // Display the cooking time
                              style: const TextStyle(color: Color(0xFF4E4D4D)),
                            ),
                            const Spacer(),  // Add a space between cooking time and category
                            Text(
                              recipe.category.toString().split('.').last,  // Display the category of the recipe
                              style: const TextStyle(color: Color(0xFF4E4D4D)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -15,  // Position the image slightly outside the card
                  left: isPhotoOnLeft ? 0 : null,  // Position image on the left or right depending on the flag
                  right: isPhotoOnLeft ? null : 0,
                  child: Material(
                    elevation: 4,  // Elevation for the image to stand out
                    borderRadius: BorderRadius.circular(75),  // Make the image circular
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),  // Clip the image into a circle
                      child: recipe.imagePath != null && recipe.imagePath!.isNotEmpty
                          ? Image.asset(
                        recipe.imagePath!,  // Use this for local images
                        width: 130,  // Set the width of the image
                        height: 130,  // Set the height of the image
                        fit: BoxFit.cover,  // Make sure the image covers the area
                      )
                          : (recipe.photoUrl != null && recipe.photoUrl!.isNotEmpty
                          ? Image.network(
                        recipe.photoUrl!,  // Use this for remote images
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        getCategoryDefaultImage(recipe.category),  // Default image if no image or URL is available
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
