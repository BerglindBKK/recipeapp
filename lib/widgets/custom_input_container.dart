import 'package:flutter/material.dart';

// This widget is a custom container for input fields (like TextFields) with a label, customizable height, and styling.
class CustomInputContainer extends StatelessWidget {
  final String labelText; // The label text to show inside the container (e.g., 'Recipe Title')
  final TextEditingController controller; // Controller to manage the text input
  final double? height; // Custom height of the container (optional)
  final bool readOnly; // Flag to make the input field read-only (optional, default is false)
  final bool isNumberField; // Flag to restrict input to numbers only (optional)

  // Constructor to initialize the properties of the input container
  const CustomInputContainer({
    super.key,
    required this.labelText, // The label text for the input field
    required this.controller, // The controller that holds the input text
    this.height, // Optional height for the container (defaults to 60)
    this.readOnly = false, // By default, input is not read-only
    this.isNumberField = false,  // Default is false, so it allows text and numbers
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Makes the container take up the full width of its parent
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16), // Padding inside the container
      margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16), // Margin around the container
      decoration: BoxDecoration(
        color: Colors.grey[50], // Light grey background color for the input container
        borderRadius: BorderRadius.circular(8), // Rounded corners for the container
        boxShadow: [
          // A soft shadow effect for a subtle 3D appearance
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05), // Light shadow color with opacity
            offset: const Offset(0, 2), // Slight shadow offset
            blurRadius: 8, // Blur effect for the shadow
            spreadRadius: 2, // Spread of the shadow
          ),
        ],
      ),
      child: SizedBox(
        height: height ?? 60, // Height of the input field, defaults to 60 if not provided
        child: TextField(
          controller: controller, // The TextEditingController to manage the text input
          readOnly: readOnly, // Whether the input field is read-only or not
          maxLines: null, // Allow the input field to grow vertically (multiline)
          keyboardType: isNumberField
              ? const TextInputType.numberWithOptions(decimal: true) // Number keyboard if isNumberField is true
              : TextInputType.multiline, // Multiline keyboard for general text input
          decoration: InputDecoration(
            labelText: labelText, // The label to show inside the input field (e.g., 'Recipe Title')
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6), // Label color with some transparency
            ),
            border: InputBorder.none, // No border around the input field
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0), // Padding inside the text field
          ),
        ),
      ),
    );
  }
}
