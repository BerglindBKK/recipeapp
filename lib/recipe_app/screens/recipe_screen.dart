import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import '../../widgets/big_recipe_card.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeScreen({required this.recipe, super.key});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    // Check if the recipe is already a favorite
    _isFavorite = _checkIfFavorite(widget.recipe);
  }

  // Example function to check if the recipe is in the favorites list
  bool _checkIfFavorite(Recipe recipe) {
    // You can add your logic for checking if a recipe is in the favorites list
    // Here I'm returning false by default
    return false;
  }

  // Toggle the favorite status of the recipe
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      // You can perform any additional logic to add/remove the recipe from the favorites list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
              'assets/default_recipe_image.jpg',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
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
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: BigRecipeCard(
                recipe: widget.recipe, // Pass the recipe
                isFavorite: _isFavorite, // Pass the isFavorite flag
                toggleFavorite: _toggleFavorite, // Pass the toggleFavorite function
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Stack(
        children: [
          Positioned(
            top: 16,
            left: 4,
            child: Opacity(
              opacity: 0.75,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 32,
            child: Opacity(
              opacity: 0.75,
              child: FloatingActionButton(
                onPressed: _toggleFavorite,
                backgroundColor: Colors.white,
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
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
