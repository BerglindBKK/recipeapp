import 'package:flutter/material.dart';

class MainScreenButton extends StatelessWidget {
  // Constructor to initialize the button with the function (onTap) and the button text (buttonText)
  const MainScreenButton({
    super.key,
    required this.onTap, // A function that is triggered when the button is tapped
    required this.buttonText, // The text that will be displayed on the button
  });

  // Function that will be executed when the button is pressed
  final void Function() onTap;

  // The text displayed on the button, passed from the parent widget
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    // Get the current color scheme of the app, which defines colors for different UI elements
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onTap, // This calls the function passed as 'onTap' when the button is pressed
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.surface, // Sets the background color of the button
        foregroundColor: colorScheme.onSurface, // Sets the text color for the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Sets rounded corners for the button
        ),
        elevation: 2.0, // Adds a small shadow effect to give the button a raised appearance
      ),
      child: Text(
        buttonText, // The text that will be displayed on the button
        textAlign: TextAlign.center, // Centers the text inside the button
        style: const TextStyle(
          fontSize: 16, // Sets the font size for the button text
          fontWeight: FontWeight.bold, // Makes the text bold
          color: Colors.black87, // Text color is a dark shade of black
          shadows: [], // Removes any text shadow (could be added for effects if needed)
        ),
      ),
    );
  }
}
