import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/colors.dart';
import 'package:recipeapp/recipe_app/screens/recipe_screen.dart';  // Import RecipeScreen

class RecipeCard extends StatelessWidget {
  final Recipe recipe;  // Recipe object that holds all information about the recipe
  final bool isPhotoOnLeft;  // Flag to determine if the photo is on the left or right side
  final bool isFavorite; // To track whether the recipe is marked as a favorite
  final VoidCallback toggleFavorite; // Function to toggle the favorite status

  const RecipeCard({
    required this.recipe,
    required this.isPhotoOnLeft,
    required this.isFavorite, // Accept isFavorite to show whether it's a favorite or not
    required this.toggleFavorite, // Accept toggleFavorite to toggle the favorite status
    super.key
  });

  // This function returns the category color based on the recipe's category (meat, fish, etc.)
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
      default:
        return Colors.grey;
    }
  }

  String getCategoryDefaultImage(Category category) {
    switch (category) {
      case Category.meat:
        return 'assets/images/default_meat.png';
      case Category.fish:
        return 'assets/images/default_fish.png';
      case Category.pasta:
        return 'assets/images/default_pasta.png';
      case Category.salad:
        return 'assets/images/default_salad.png';
      case Category.dessert:
        return 'assets/images/default_dessert.png';
    //default:
    //  return 'assets/images/default_meat.png';  // Default image if the category is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeScreen(recipe: recipe),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10),
        child: SizedBox(
          height: 110,
          child: Card(
            color: _getCategoryColor(recipe.category),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(48),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  left: isPhotoOnLeft ? 125 : 15,
                  right: isPhotoOnLeft ? 15 : 135,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF4E4D4D),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ) ?? const TextStyle(
                            color: Color(0xFF4E4D4D),
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              ' ${recipe.cookingTime} min',
                              style: const TextStyle(color: Color(0xFF4E4D4D)),
                            ),
                            const Spacer(),
                            Text(
                              recipe.category.toString().split('.').last,
                              style: const TextStyle(color: Color(0xFF4E4D4D)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            Positioned(
              top: -15,
              left: isPhotoOnLeft ? 0 : null,
              right: isPhotoOnLeft ? null : 0,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(75),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: recipe.imagePath != null && recipe.imagePath!.isNotEmpty
                      ? Image.asset(
                    recipe.imagePath!, // Use this for local images
                    width: 130,
                    height: 130,
                    fit: BoxFit.cover,
                  )
                      : (recipe.photoUrl != null && recipe.photoUrl!.isNotEmpty
                      ? Image.network(
                    recipe.photoUrl!, // Use this for remote images
                    width: 130,
                    height: 130,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    getCategoryDefaultImage(recipe.category),
                    width: 130,
                    height: 130,
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),

            // Add Favorite Button
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: toggleFavorite, // Calls the toggleFavorite callback
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
