import 'package:flutter/material.dart';
//import 'package:flutter/services.dart'; // Required for input formatters

// This widget is a custom container for input fields (like TextFields) with a label, customizable height, and styling.
class CustomInputContainer extends StatelessWidget {
  final String labelText; // The label text to show inside the container (e.g., 'Recipe Title')
  final TextEditingController controller; // Controller to manage the text input
  final double? height; // Custom height of the container (optional)
  final bool readOnly; // Flag to make the input field read-only (optional, default is false)
  final bool isNumberField; // Flag to restrict input to numbers only (optional)

  const CustomInputContainer({
    super.key,
    required this.labelText,
    required this.controller,
    this.height,
    this.readOnly = false,
    this.isNumberField = false,  // Default is false, so it allows text and numbers
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // The container takes up the full width of the screen
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50], // Light grey background color for the input container
        borderRadius: BorderRadius.circular(8), // Rounded corners for the container
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SizedBox(
        height: height ?? 60, // Default height, can be adjusted
        child: TextField(
          controller: controller,
          readOnly: readOnly,
          maxLines: null, // Allow multiline input
          keyboardType: isNumberField
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.multiline, // Multiline keyboard or number keyboard
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          ),
        ),
      ),
    );
  }
}
