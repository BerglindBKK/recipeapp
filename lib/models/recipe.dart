import 'package:uuid/uuid.dart';

const uuid = Uuid();

// Defines the categories
enum Category { meat, fish, pasta, salad, dessert }

//defines recipe class. Each recipe is assigned a unique ID using UUID.v4()
class Recipe {
  Recipe({
    required this.title,
    required this.instructions,
    required this.ingredients,
    required this.cookingTime,
    required this.category,
    this.isFavorite = false,  // Make it mutable and provide a default value of false
    this.imagePath,
    this.photoUrl,
  }) : id = uuid.v4();

  final String id;  // Unique ID for each recipe
  final String title;
  final String instructions;
  final String ingredients;
  final String cookingTime;
  final Category category;
  bool isFavorite; // Change this to non-final so it can be modified
  final String? imagePath; // stores image path
  final String? photoUrl; // URL for an online photo
}
