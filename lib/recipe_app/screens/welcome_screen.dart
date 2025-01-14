import 'package:flutter/material.dart';
//import 'package:recipeapp/theme.dart';
import 'package:recipeapp/widgets/main_screen_button.dart';
//import 'package:recipeapp/widgets/recipe_card.dart';
//import 'package:recipeapp/widgets/recipes_list.dart';
//import 'package:recipeapp/models/recipe.dart';
//import 'package:recipeapp/recipe_app/screens/all_recipes_screen.dart';
//import 'package:text_hover/config.dart';
//import 'package:text_hover/text_hover.dart';
//import 'package:lokaverkefni/widgets/floating_action_button.dart';

// The welcome page
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.onNavigate});

  final void Function(String screen) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //title: const Text('Welcome'),
        //actions: [
        //IconButton(
        //onPressed: onBack,
        //icon: const Icon(Icons.arrow_back),
        //),
        //],
      //),
      // Stack for overlaying widgets on top of each other (background + content)
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/recipe_app_landing.jpg'),
                fit: BoxFit.cover, // Image covers the entire screen
              ),
            ),
          ),
// White overlay with opacity
          Container(
            color: Colors.white.withValues(alpha:0.6),  // White overlay with opacity
          ),

          // Overlay content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Button 1
                SizedBox(
                  width: double.infinity,
                  child: MainScreenButton(
                    onTap: () => onNavigate('all-recipes'),
                    buttonText: 'ALL RECIPES',
                  ),
                ),
                const SizedBox(height: 10),
                // Button 2
                SizedBox(
                  width: double.infinity,
                  child: MainScreenButton(
                    onTap: () => onNavigate('add-recipes'),
                    buttonText: 'ADD A RECIPE',
                  ),
                ),
                const SizedBox(height: 10),
                // Button 3
                SizedBox(
                  width: double.infinity,
                  child: MainScreenButton(
                    onTap: () => onNavigate('favorites'),
                    buttonText: 'FAVORITE RECIPES',
                  ),
                ),
                // RecipeCard
                //SizedBox(
                //width: double.infinity,
                //child: RecipeCard(
                //recipes[index],
                //onTap: () => onNavigate('add-recipes'),
                //cardText : 'Title frá welcome_screen',
                //title: recipe.title
                //cardText: 'HALLÓ SÉST ÉG??',
                //),
                //),
              ],
            ),
          ),
        ],
      ),
      //floatingActionButton: FloatingActionButton(
      //  elevation: 10.0,
      //  onPressed: () => onNavigate('add-recipes'),
      //  child: const Icon(Icons.add),  // Icon inside the button
      //),
    );
  }
}
