import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import '../../widgets/big_recipe_card.dart';

// RecipeScreen displays the details of a single recipe
class RecipeScreen extends StatefulWidget {
  final Recipe recipe; // The recipe passed into this screen

  const RecipeScreen({required this.recipe, super.key});

  @override
  // Use the public state class name (RecipeScreenState)
  RecipeScreenState createState() => RecipeScreenState();
}

// Changed _RecipeScreenState to RecipeScreenState to make it public
class RecipeScreenState extends State<RecipeScreen> {
  late bool _isFavorite;  // Tracks whether the recipe is marked as favorite

  @override
  void initState() {
    super.initState();
    // Initialize the favorite status when the screen is created
    _isFavorite = _checkIfFavorite(widget.recipe);
  }

  // Function to check if the recipe is a favorite
  // This is a placeholder, logic can be added to check the actual favorites list
  bool _checkIfFavorite(Recipe recipe) {
    return false;  // Default is false, but should be updated based on actual logic
  }

  // Toggle the favorite status of the recipe
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;  // Flip the favorite status
      // Add your favorite list management logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Display the image of the recipe, either from local asset or a network URL
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: widget.recipe.imagePath != null && widget.recipe.imagePath!.isNotEmpty
                ? Image.asset(
              widget.recipe.imagePath!,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            )
                : widget.recipe.photoUrl != null && widget.recipe.photoUrl!.isNotEmpty
                ? Image.network(
              widget.recipe.photoUrl!,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            )
                : Image.asset(
              'assets/default_recipe_image.jpg',  // Default image when no URL or asset provided
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          // Container with rounded corners for the recipe details
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(48),
                  topRight: Radius.circular(48),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),  // Shadow effect for a subtle 3D look
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: BigRecipeCard(
                recipe: widget.recipe, // Pass the recipe to the card
                isFavorite: _isFavorite, // Pass the current favorite status
                toggleFavorite: _toggleFavorite, // Pass the toggle function
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Stack(
        children: [
          // Back button to go back to the previous screen
          Positioned(
            top: 16,
            left: 4,
            child: Opacity(
              opacity: 0.75,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);  // Pop the current screen from the navigation stack
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
          // Favorite button to toggle favorite status
          Positioned(
            top: 16,
            right: 32,
            child: Opacity(
              opacity: 0.75,
              child: FloatingActionButton(
                onPressed: _toggleFavorite,  // Trigger the favorite toggle function
                backgroundColor: Colors.white,
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,  // Show different icons based on favorite status
                  color: _isFavorite ? Colors.red : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
