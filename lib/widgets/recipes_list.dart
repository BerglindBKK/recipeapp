import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/widgets/recipe_card.dart';
import 'package:recipeapp/recipe_app/screens/recipe_screen.dart';

class RecipesList extends StatelessWidget {
  const RecipesList({
    super.key,
    required this.recipes,
    required this.onDeleteRecipe,
    required this.toggleFavorite,
    required this.onRecipeTap,
  });

  final List<Recipe> recipes;
  final Function(Recipe) onDeleteRecipe;
  final Function(Recipe) toggleFavorite;
  final Function(Recipe) onRecipeTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ListView.separated(
        itemCount: recipes.isEmpty ? 1 : recipes.length,
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
              color: Colors.red.withOpacity(0.75),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: GestureDetector(
              onTap: () => onRecipeTap(recipes[index]),
              child: RecipeCard(
                recipe: recipes[index],
                isPhotoOnLeft: index % 2 == 0,
                isFavorite: recipes[index].isFavorite,
                toggleFavorite: () => toggleFavorite(recipes[index]),
              ),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(height: 30);
        },
      ),
    );
  }
}
