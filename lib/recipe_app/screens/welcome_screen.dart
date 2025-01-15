import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/main_screen_button.dart';

// WelcomeScreen displays a welcome page with three buttons to navigate to different screens
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.onNavigate});

  // onNavigate is a callback function passed from the parent to navigate to different screens
  final void Function(String screen) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color of the screen
      body: Stack(
        children: [
          // Background image that is placed behind the other content
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: const Alignment(0.0, -0.2), // Align image slightly above center
              child: Container(
                width: 300,  // Width of the background image
                height: 250, // Height of the background image
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/forsida2.png'), // Background image file
                    fit: BoxFit.cover,  // Make sure the image covers the area
                  ),
                ),
              ),
            ),
          ),

          // Overlay content (the buttons are placed on top of the background)
          Padding(
            padding: const EdgeInsets.all(16.0),  // Padding around the content
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
              children: [
                const SizedBox(height: 350),  // Spacer to position buttons downwards
                // Button 1 (to navigate to all recipes screen)
                SizedBox(
                  width: double.infinity,  // Make the button take up full width
                  child: MainScreenButton(
                    onTap: () => onNavigate('all-recipes'),  // Navigate to 'all-recipes' screen
                    buttonText: 'ALL RECIPES',  // Text shown on the button
                  ),
                ),
                const SizedBox(height: 10),  // Spacer between buttons
                // Button 2 (to navigate to add recipes screen)
                SizedBox(
                  width: double.infinity,  // Make the button take up full width
                  child: MainScreenButton(
                    onTap: () => onNavigate('add-recipes'),  // Navigate to 'add-recipes' screen
                    buttonText: 'ADD A RECIPE',  // Text shown on the button
                  ),
                ),
                const SizedBox(height: 10),  // Spacer between buttons
                // Button 3 (to navigate to favorite recipes screen)
                SizedBox(
                  width: double.infinity,  // Make the button take up full width
                  child: MainScreenButton(
                    onTap: () => onNavigate('favorites'),  // Navigate to 'favorites' screen
                    buttonText: 'FAVORITE RECIPES',  // Text shown on the button
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}