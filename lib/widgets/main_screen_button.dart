import 'package:flutter/material.dart';

class MainScreenButton extends StatelessWidget {
  const MainScreenButton({
    super.key,
    required this.onTap, // A function that is triggered when the button is tapped
    required this.buttonText, // The text that will be displayed on the button
  });

  final void Function() onTap; // The function to call when the button is pressed
  final String buttonText; // The label of the button, passed from the parent widget

  @override
  Widget build(BuildContext context) {
    // This gets the color scheme of the app to use for the button
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onTap, // This will run the function passed as 'onTap'
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.surface, // Set the background color of the button
        foregroundColor: colorScheme.onSurface, // Set the text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Make the corners of the button rounded
        ),
        elevation: 2.0, // Adds shadow to the button to give it a raised effect
      ),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87, // Set text color to black87
          shadows: [], // Remove the shadow
        ),
      ),

    );
  }
}
