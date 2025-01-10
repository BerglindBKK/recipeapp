import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/data/recipe_data.dart';
import 'package:recipeapp/recipe_app/screens/recipe_screen.dart';
import 'package:recipeapp/colors.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;  // Recipe object that holds all information about the recipe
  final bool isPhotoOnLeft;  // Flag to determine if the photo is on the left or right side

  // Constructor to initialize the recipe and photo alignment flag
  const RecipeCard({required this.recipe, required this.isPhotoOnLeft, super.key});

  // This function returns the category color based on the recipe's category (meat, fish, etc.)
  Color _getCategoryColor(Category category) {
    switch (category) {
      case Category.meat:
        return AppColors.meat;  // Using custom colors defined in AppColors
      case Category.fish:
        return AppColors.fish;
      case Category.pasta:
        return AppColors.pasta;
      case Category.salad:
        return AppColors.salad;
      case Category.dessert:
        return AppColors.dessert;
      //default:
        //return Colors.grey;  // Default color if the category is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // When the card is tapped, it navigates to the RecipeScreen with the recipe details
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeScreen(recipe: recipe),  // Passing the recipe to the next screen
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left:25.0, right:25.0, top:10),  // Add 25px padding around the card
        child: SizedBox(
          height: 110,  // Set the height of the card to 100
          child: Card(
            // Card with background color corresponding to the category
            color: _getCategoryColor(recipe.category),  // Set the background color of the card based on category
            elevation: 2,  // Add shadow for the card to make it slightly elevated
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48),  // Rounded corners for the card
            ),
            child: Stack(
              clipBehavior: Clip.none,  // Allow the photo to overlap the card's edges
              children: [
                // Positioned text block
                Positioned(
                  top: 0,  // Align it at the top
                  left: isPhotoOnLeft ? 125 : 15,  // Adjust left position based on photo position
                  right: isPhotoOnLeft ? 15 : 135,  // Adjust right position based on photo position
                  bottom: 0,  // Align it to the bottom
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16, // Adding padding on the left side for text
                      right: 16,
                      top: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,  // Align text to the left
                      children: [
                        // Recipe title, if no title, show 'No Title'
                        Text(
                          recipe.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF4E4D4D),  // Set text color to #4E4D4D
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ) ?? const TextStyle(
                            color: Color(0xFF4E4D4D),  // Set text color to #4E4D4D
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 8),  // Space between title and cooking time
                        Row(
                          children: [
                            //Icon(Icons.timer, color: Color(0xFF4E4D4D)),  // Set icon color to #4E4D4D
                            //const SizedBox(width: 8),  // Space between icon and cooking time text
                            Text(
                              ' ${recipe.cookingTime} min',  // Show cooking time or 'Unknown'
                              style: const TextStyle(color: Color(0xFF4E4D4D)),  // Set text color to #4E4D4D
                            ),
                            const Spacer(),  // Space between cooking time and category box
                            // Category name in a text box (no background color)
                            Text(
                              recipe.category.toString().split('.').last,  // Display category name (like 'meat', 'fish')
                              style: const TextStyle(color: Color(0xFF4E4D4D)),  // Set category text color to #4E4D4D
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Positioned photo of the recipe (overlapping slightly above the card)
                Positioned(
                  top: -15,  // Vertically align the photo
                  left: isPhotoOnLeft ? 0 : null,  // Position photo to the left
                  right: isPhotoOnLeft ? null : 0,  // Position photo to the right
                  child: Material(
                    elevation: 4,  // Add elevation to the photo for shadow effect
                    borderRadius: BorderRadius.circular(75),  // Ensure the photo is circular
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),  // Keep the circular shape
                      child: recipe.imagePath != null && recipe.imagePath!.isNotEmpty // Check if imagePath exists and is not empty
                      ? Image.asset(
                        recipe.imagePath!,  // Load the image from local assets
                        width: 130,  // Set width of the photo
                        height: 130,  // Set height of the photo
                        fit: BoxFit.cover,  // Ensure the image covers the box without distortion
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);  // Show error if image fails to load
                        },
                      )
                      // If imagePath doesn't exist, try photoUrl (for network images):
                      : recipe.photoUrl != null && recipe.photoUrl!.isNotEmpty
                        ? Image.network(
                          recipe.photoUrl!,  // Load the image from network
                          width: 130,  // Set width of the photo
                          height: 130,  // Set height of the photo
                          fit: BoxFit.cover,  // Ensure the image covers the box without distortion
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);  // Show error if image fails to load
                          },
                        )
                      // If neither imagePath nor photoUrl exists, use default image
                      : Image.asset(
                        getCategoryDefaultImage(recipe.category),  // Fallback image if no URL
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
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
