import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';  // Import image_picker for image selection
import 'package:permission_handler/permission_handler.dart';  // Import permission_handler to manage permissions
import 'dart:io';  // Import File to handle picked image
import 'package:recipeapp/models/recipe.dart';  // Import Recipe model to use in your app

class NewRecipe extends StatefulWidget {
  const NewRecipe({
    super.key,
    required this.onBack, // Callback to go back to the previous screen
    required this.title,  // Title for the new recipe
    required this.onAddRecipe, // Callback to add the new recipe
  });

  final void Function(Recipe recipe) onAddRecipe;  // Callback to add a new recipe
  final VoidCallback onBack;  // Callback to navigate back
  final String title;  // Title of the new recipe screen

  @override
  State<NewRecipe> createState() {
    return _NewRecipeState();
  }
}

class _NewRecipeState extends State<NewRecipe> {
  File? _image;  // Variable to store the picked image
  final ImagePicker _picker = ImagePicker();  // Instance of ImagePicker to pick images from camera or gallery

  // Method to pick an image from the camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    // Request permission to access photos on the device
    PermissionStatus permissionStatus = await Permission.photos.request();

    if (!mounted) return;  // Check if the widget is still mounted before using context

    if (permissionStatus.isGranted) {
      // Permission granted, proceed to pick an image
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null && mounted) {
        setState(() {
          _image = File(pickedFile.path);  // Store the selected image in the _image variable
        });
      }
    } else if (permissionStatus.isDenied || permissionStatus.isRestricted) {
      // If permission is denied or restricted, show an alert
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Permission Denied'),
            content: const Text('Please grant permission to access your photo gallery.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);  // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      // If the permission is permanently denied, show instructions to open settings
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Permission Denied Permanently'),
            content: const Text('You have permanently denied permission to access your gallery. Please open app settings and enable the permission manually.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);  // Close the dialog
                  openAppSettings(); // Open app settings for the user to enable permission
                },
                child: const Text('Go to Settings'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);  // Close the dialog
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Option to pick an image from the gallery or camera
          ElevatedButton(
            onPressed: () {
              _showImageSourceDialog();  // Show a dialog to choose between camera or gallery
            },
            child: const Text('Pick an Image'),
          ),

          // Display the selected image, if any
          if (_image != null)
            Image.file(
              _image!,
              height: 200,
              width: 200,
            ),

          // Add any other input fields for the recipe title, ingredients, etc.
        ],
      ),
    );
  }

  // Show a dialog to choose the image source (camera or gallery)
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);  // Close the dialog
                _pickImage(ImageSource.camera);  // Allow the user to pick an image from the camera
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);  // Close the dialog
                _pickImage(ImageSource.gallery);  // Allow the user to pick an image from the gallery
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }
}
