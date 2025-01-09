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
        backgroundColor: colorScheme.primary, // Set the background color of the button
        foregroundColor: colorScheme.surface, // Set the text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), // Make the corners of the button rounded
          side: BorderSide(
            color: colorScheme.primary, // Set the border color to the primary color
            width: 1.0, // Set the border width
          ),
        ),
        elevation: 8.0, // Adds shadow to the button to give it a raised effect
      ),
      child: Text(
        buttonText, // Display the button text passed as a parameter
        textAlign: TextAlign.center, // Center the text inside the button
        style: TextStyle(
          fontSize: 18, // Set the font size of the text
          fontWeight: FontWeight.bold, // Make the text bold
          shadows: [
            Shadow(
              offset: Offset(1.0, 1.0), // Set the position of the shadow
              blurRadius: 3.0, // Set how blurry the shadow is
              color: Color.fromARGB(50, 0, 0, 0), // Set the shadow color (semi-transparent black)
            ),
          ],
        ),
      ),
    );
  }
}
