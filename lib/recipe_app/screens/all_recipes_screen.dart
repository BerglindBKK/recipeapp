import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/recipes_list.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/recipe_app/screens/favorites_screen.dart';

class AllRecipesScreen extends StatefulWidget {
  final List<Recipe> recipes;
  final VoidCallback onBack;
  final Function(String) onNavigate;
  final Function(Recipe) onRecipeTap;

  const AllRecipesScreen({
    super.key,
    required this.recipes,
    required this.onBack,
    required this.onNavigate,
    required this.onRecipeTap,
  });

  @override
  State<AllRecipesScreen> createState() => _AllRecipesScreenState();
}

class _AllRecipesScreenState extends State<AllRecipesScreen> {
  String query = "";

  void _deleteRecipe(Recipe recipe) {
    setState(() {
      widget.recipes.remove(recipe);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${recipe.title} deleted'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
    });
  }

  List<Recipe> _getFilteredRecipes(String query) {
    return widget.recipes
        .where((recipe) =>
    recipe.title.toLowerCase().contains(query.toLowerCase()) ||
        recipe.ingredients.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 48.0, left: 16),
          child: Row(
            children: [
              IconButton(
                onPressed: widget.onBack,
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const Text('All Recipes', style: TextStyle(fontSize: 24, color: Colors.black)),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          /*Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/recipe_app_landing.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),*/
          Container(
            color: Colors.white.withOpacity(0.8),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 8),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: TextField(
                    onChanged: (String newQuery) {
                      setState(() {
                        query = newQuery;
                      });
                    },
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: 'Search recipes...',
                      hintStyle: TextStyle(color: Color(0xFFA5A5A5)),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Icon(
                          Icons.search,
                          color: Color(0xFFA5A5A5),
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RecipesList(
                  recipes: _getFilteredRecipes(query),
                  onDeleteRecipe: _deleteRecipe,
                  toggleFavorite: _toggleFavorite,
                  onRecipeTap: widget.onRecipeTap,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: colorScheme.surface, // Set the background color of the button
              foregroundColor: colorScheme.onSurface, // Set the text color
              elevation: 5.0,
              hoverElevation: 10.0,
              onPressed: () => widget.onNavigate('add-recipes'),
              //backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
