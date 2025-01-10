import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/widgets/recipe_card.dart';

class RecipesList extends StatelessWidget {
  const RecipesList({
    super.key,
    required this.recipes,
    required this.onDeleteRecipe,  // Callback for deleting a recipe
  });

  final List<Recipe> recipes;
  final Function(Recipe) onDeleteRecipe;  // Callback for deleting recipe

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),  // Add space above the ListView
      child: ListView.separated(
        itemCount: recipes.isEmpty ? 1 : recipes.length, // Display placeholder if empty
        itemBuilder: (ctx, index) {
          if (recipes.isEmpty) {
            return const Center(child: Text('No recipes available.'));
          }

          return Dismissible(
            key: ValueKey(recipes[index].id),
            onDismissed: (direction) {
              onDeleteRecipe(recipes[index]);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${recipes[index].title} deleted'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            background: Container(
              color: Colors.red.withValues(alpha:0.75),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: RecipeCard(
              recipe: recipes[index],
              isPhotoOnLeft: index % 2 == 0,  // Alternate photo position based on index
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(height: 30);  // Add space between items
        },
      ),
    );
  }
}
