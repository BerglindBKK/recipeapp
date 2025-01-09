import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for input formatters
import 'package:recipeapp/models/recipe.dart';
import 'package:recipeapp/widgets/custom_input_container.dart'; // Import custom input container
import 'package:recipeapp/colors.dart'; // Import the colors file for category color management

// This is the AddRecipesScreen where users can add a new recipe.
class AddRecipesScreen extends StatefulWidget {
  const AddRecipesScreen({
    super.key,
    required this.onBack,  // Callback to navigate back to previous screen
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

  // Function to handle submitting the recipe data
  void _submitRecipeData() {
    // Check if any of the required fields are empty
    if (_titleController.text.trim().isEmpty ||
        _ingredientsController.text.trim().isEmpty ||
        _instructionsController.text.trim().isEmpty ||
        _photoUrlController.text.trim().isEmpty) {
      // If some fields are empty, show an error dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          // Error message
          content: const Text('All fields must be filled out!'),
          // Warning message
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

    // Create a new Recipe object with the data entered by the user
    Recipe newRecipe = Recipe(
      title: _titleController.text,
      ingredients: _ingredientsController.text,
      instructions: _instructionsController.text,
      category: _selectedCategory,
      cookingTime: _cookingTimeController.text.isEmpty
          ? 'Unknown' // Default cooking time if the user leaves it empty
          : _cookingTimeController.text,
      photoUrl: _photoUrlController.text,
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
    super.dispose(); // Call the superclass's dispose method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Photo Section (placed above the recipe form)
          _photoUrlController.text.isNotEmpty
              ? ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
            child: Image.network(
              _photoUrlController.text, // Show the image from the URL
              width: double.infinity,
              height: 300, // Adjust height for the photo
              fit: BoxFit.cover, // Make the image cover the space
            ),
          )
              : ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
            child: Image.asset(
              'assets/images/raekjur.jpg',
              // Default image if no URL is provided
              width: double.infinity,
              height: 250, // Same height for default image
              fit: BoxFit.cover, // Cover the space with the image
            ),
          ),

          // Recipe Form Section (below the photo)
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                // Light grey background for the form container
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(48),
                  topRight: Radius.circular(48),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Light shadow effect
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
                          // Cooking Time Input (numbers only)
                          Expanded(
                            child: CustomInputContainer(
                              labelText: 'Cooking Time (min)',
                              controller: _cookingTimeController,
                              isNumberField: true, // Restrict input to numbers only
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Category Dropdown
                          Expanded(
                            child: DropdownButton<Category>(
                              value: _selectedCategory,
                              // Currently selected category
                              items: Category.values
                                  .map(
                                    (category) => DropdownMenuItem<Category>(
                                  value: category,
                                  child: Row(
                                    children: [
                                      // Show a colored circle for the category
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: _getCategoryColor(category),
                                          // Color for the category
                                          shape: BoxShape.circle, // Make it circular
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // Display the category name with text style
                                      Text(
                                        category.name,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.6),
                                          // Matching text color
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500, // Matching font weight
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                                  .toList(),
                              onChanged: (value) {
                                if (value == null)
                                  return; // No change if the value is null
                                setState(() {
                                  _selectedCategory = value; // Update the selected category
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Ingredients input field (larger height)
                    CustomInputContainer(
                      labelText: 'Ingredients',
                      controller: _ingredientsController,
                      height: 120,
                      isNumberField: false, // It should allow text and numbers
                    ),

                    // Instructions input field (larger height)
                    CustomInputContainer(
                      labelText: 'Instructions',
                      controller: _instructionsController,
                      height: 120,
                      isNumberField: false, // It should allow text and numbers
                    ),

                    // Photo URL input field
                    CustomInputContainer(
                      labelText: 'Photo URL',
                      controller: _photoUrlController,
                      height: 50,
                    ),

                    // Save Button
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitRecipeData,
                      // Submit the recipe data when clicked
                      child: const Text('Save Recipe'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Floating action button (back button)
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Stack(
        children: [
          Positioned(
            top: 16,
            left: 4,
            child: Opacity(
              opacity: 0.75,
              child: FloatingActionButton(
                onPressed: widget.onBack, // Go back when this button is pressed
                backgroundColor: Colors.white,
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to get the category color based on the selected category
  Color _getCategoryColor(Category category) {
    switch (category) {
      case Category.meat:
        return AppColors.meat; // Return the 'meat' color from the AppColors class
      case Category.fish:
        return AppColors.fish; // Return the 'fish' color
      case Category.pasta:
        return AppColors.pasta; // Return the 'pasta' color
      case Category.salad:
        return AppColors.salad; // Return the 'salad' color
      case Category.dessert:
        return AppColors.dessert; // Return the 'dessert' color
      default:
        return Colors.grey; // Default color if no category is selected
    }
  }
}
