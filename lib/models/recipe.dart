import 'package:uuid/uuid.dart';

// Generate unique ID for each recipe
const uuid = Uuid();

// Categories for recipe classification
enum Category { meat, fish, pasta, salad, dessert }

class Recipe {
  // Constructor to initialize recipe with required and optional fields
  Recipe({
    required this.title,
    required this.instructions,
    required this.ingredients,
    required this.cookingTime,
    required this.category,   // Recipe category (meat, fish, etc.)
    this.isFavorite = false,  // Default: not a favorite
    this.imagePath,           // Optional local image path
    this.photoUrl,            // Optional URL for online image
  }) : id = uuid.v4();        // Generate unique ID for each recipe

  final String id;            // Unique recipe ID
  final String title;
  final String instructions;
  final String ingredients;
  final String cookingTime;
  final Category category;
  bool isFavorite;            // Whether the recipe is marked as a favorite
  final String? imagePath;
  final String? photoUrl;
}
