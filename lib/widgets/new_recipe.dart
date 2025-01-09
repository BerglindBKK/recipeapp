import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/custom_input_container.dart';
import 'package:recipeapp/models/recipe.dart';
import 'package:image_picker/image_picker.dart';  // Import image_picker
import 'dart:io';  // Import File to handle picked image

class NewRecipe extends StatefulWidget {
  const NewRecipe({
    super.key,
    required this.onBack,
    required this.title,
    required this.onAddRecipe
  });

  final void Function(Recipe recipe) onAddRecipe;
  final VoidCallback onBack;
  final String title;

  @override
  State<NewRecipe> createState() {
    return _NewRecipeState();
  }
}

class _NewRecipeState extends State<NewRecipe> {
  final _titleController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _photoUrlController = TextEditingController();
  Category _selectedCategory = Category.dessert;

  // Add a variable to store the picked image
  File? _image;

  final ImagePicker _picker = ImagePicker();  // Image picker instance

  // Method to pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);  // Store the picked image in the _image variable
      });
    }
  }

  // Method to show a dialog to select between camera and gallery
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);  // Pick image from camera
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);  // Pick image from gallery
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  // Save button functionality
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Title container with TextEditingController
          CustomInputContainer(
            labelText: 'Recipe Title',
            controller: _titleController,
          ),

          // Ingredients
          CustomInputContainer(
            labelText: 'Ingredients',
            controller: _ingredientsController,
            height: 200,
          ),

          // Procedure
          CustomInputContainer(
            labelText: 'Instructions',
            controller: _instructionsController,
            height: 200,
          ),

          CustomInputContainer(
            labelText: 'Photo URL',
            controller: _photoUrlController,
            height: 200,
          ),

          // Option to pick image
          ElevatedButton(
            onPressed: _showImageSourceDialog, // Show dialog to pick image source
            child: const Text('Pick an Image'),
          ),

          // Display the selected image
          if (_image != null)
            Image.file(
              _image!,
              height: 200,
              width: 200,
            ),

          // Save button
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty && _ingredientsController.text.isNotEmpty && _instructionsController.text.isNotEmpty && _photoUrlController.text.isNotEmpty) {
                // Only add the recipe if all fields are filled
                final newRecipe = Recipe(
                  title: _titleController.text,
                  ingredients: _ingredientsController.text,
                  instructions: _instructionsController.text,
                  cookingTime: 'Unknown',
                  category: Category.dessert,
                  imagePath: _image?.path,  // bara ef local image - bíðum með þetta
                  photoUrl: _photoUrlController.text, // Store the URL
                );

                // Add the new recipe
                widget.onAddRecipe(newRecipe);

                // todo bæta við uppskrift, kalla á funciton til að bæta við lista
              } else {
                // bæta við alert?
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Error'),
                    content: const Text('All fields must be filled out!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),

          // Back to welcome screen
          ElevatedButton(
            onPressed: widget.onBack,
            child: const Text('Back to Welcome Screen'),
          ),
        ],
      ),
    );
  }
}
