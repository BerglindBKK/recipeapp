import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/main_screen_button.dart';

// The welcome page. SHows three buttons to navigate to: -all revipes screen, -add recipe screen, favorite screen

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.onNavigate});

  final void Function(String screen) onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Stack for overlaying widgets on top of each other (background + content)
      body: Stack(
        children: [
          // Background image
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: const Alignment(0.0, -0.2),
              child: Container(
                width: 300,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/forsida.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Overlay content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 350),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
