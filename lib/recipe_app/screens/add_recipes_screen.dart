import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // To work with File
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/widgets/custom_input_container.dart'; // Import custom input container
import 'package:recipeapp/colors.dart'; // Import the colors file for category color management
import 'package:permission_handler/permission_handler.dart';

class AddRecipesScreen extends StatefulWidget {
  const AddRecipesScreen({
    super.key,
    required this.onBack,  // Callback to navigate back to the previous screen
    required this.onAddRecipe,  // Callback to add the new recipe
  });

  final void Function(Recipe recipe) onAddRecipe; // Function to add the recipe to the list
  final VoidCallback onBack;  // Function to navigate back

  @override
  State<AddRecipesScreen> createState() {
    return _AddRecipesState(); // Creates the state for this screen
  }
}

class _AddRecipesState extends State<AddRecipesScreen> {
  // Controllers to capture user input in the text fields
  final _titleController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _cookingTimeController = TextEditingController();
  final _photoUrlController = TextEditingController();
  Category _selectedCategory = Category.dessert; // Default selected category is 'dessert'

  File? _pickedImage;  // Variable to hold the picked image file
  final ImagePicker _picker = ImagePicker();  // Create an instance of ImagePicker

  // Hover colors for the camera icon and text
  Color _cameraIconColor = Colors.grey[600]!;
  Color _textColor = Colors.grey[600]!;

  // Function to handle submitting the recipe data
  void _submitRecipeData() {
    // Check if any of the required fields are empty
    if (_titleController.text.trim().isEmpty ||
        _ingredientsController.text.trim().isEmpty ||
        _instructionsController.text.trim().isEmpty ||
        (_photoUrlController.text.trim().isEmpty && _pickedImage == null)) {
      // If some fields are empty, show an error dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: const Text('All fields must be filled out!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // Close the dialog
              },
              child: const Text('OK'), // Button to close the dialog
            ),
          ],
        ),
      );
      return; // Don't proceed further if fields are empty
    }

    // Handle the photo URL properly
    String photoUrl = _pickedImage != null
        ? _pickedImage!.path
        : _photoUrlController.text.isEmpty
        ? '' // Allow the photo URL to be empty
        : _photoUrlController.text;

    // Create a new Recipe object with the data entered by the user
    Recipe newRecipe = Recipe(
      title: _titleController.text,
      ingredients: _ingredientsController.text,
      instructions: _instructionsController.text,
      category: _selectedCategory,
      cookingTime: _cookingTimeController.text.isEmpty
          ? 'Unknown'
          : _cookingTimeController.text,
      photoUrl: photoUrl,  // Only assign the URL if it's not empty
    );

    // Call the onAddRecipe function to save the new recipe
    widget.onAddRecipe(newRecipe);

    // Navigate back to the previous screen after adding the recipe
    widget.onBack();
  }

  // Dispose of controllers when the screen is destroyed to free up memory
  @override
  void dispose() {
    _titleController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    _cookingTimeController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    // Check permission to access photos
    PermissionStatus status = await Permission.photos.request();

    if (status.isGranted) {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _pickedImage = File(pickedFile.path);  // Store the picked image
        });
      }
    } else {
      // Handle permission denial
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text('Please allow gallery access to pick an image.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Photo Section (placed above the recipe form)
          _pickedImage != null
              ? ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
            child: Image.file(
              _pickedImage!, // Show the picked image from the gallery
              width: double.infinity,
              height: 300, // Adjust height for the photo
              fit: BoxFit.cover, // Make the image cover the space
            ),
          )
              : Column(
            children: [
              const SizedBox(height: 90),
              GestureDetector(
                onTap: _pickImage,  // Trigger image picker on tap
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _cameraIconColor = Colors.purple; // Change icon color to purple
                      _textColor = Colors.purple; // Change text color to purple
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _cameraIconColor = Colors.grey[600]!; // Reset icon color
                      _textColor = Colors.grey[600]!; // Reset text color
                    });
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: _cameraIconColor,
                    size: 80,
                  ),
                ),
              ),
              const SizedBox(height: 16),  // Increase the space between icon and text
              Text(
                'Pick Image from Gallery',
                style: TextStyle(
                  fontSize: 16,
                  color: _textColor, // Set the color to purple on hover
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),

          // Recipe Form Section (below the photo)
          Expanded(  // Use Expanded to make the form container take remaining space
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(48),
                  topRight: Radius.circular(48),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Title input field
                    CustomInputContainer(
                      labelText: 'Recipe Title',
                      controller: _titleController,
                    ),

                    // Cooking Time and Category dropdown
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          // Cooking Time Input
                          Expanded(
                            child: CustomInputContainer(
                              labelText: 'Cooking Time (min)',
                              controller: _cookingTimeController,
                              isNumberField: true, // Allow only numbers
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Category Dropdown
                          Expanded(
                            child: DropdownButton<Category>(
                              value: _selectedCategory,
                              items: Category.values
                                  .map(
                                    (category) => DropdownMenuItem<Category>(
                                  value: category,
                                  child: Text(category.name),
                                ),
                              )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  _selectedCategory = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Ingredients input field
                    CustomInputContainer(
                      labelText: 'Ingredients',
                      controller: _ingredientsController,
                      height: 110,
                    ),

                    // Instructions input field
                    CustomInputContainer(
                      labelText: 'Instructions',
                      controller: _instructionsController,
                      height: 110,
                    ),

                    // Photo URL input field
                    CustomInputContainer(
                      labelText: 'Add photo URL if no image added (optional)',
                      controller: _photoUrlController,
                    ),

                    // Save Button
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitRecipeData,
                      child: const Text('Save Recipe'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Floating action button for back
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Stack(
        children: [
          Positioned(
            top: 16,
            left: 4,
            child: Opacity(
              opacity: 0.75,
              child: FloatingActionButton(
                onPressed: widget.onBack,
                backgroundColor: Colors.white,
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
