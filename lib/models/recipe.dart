import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Recipe model.
// Defines different food categories and icon for each category
// Uses uuid() to generate unique ID for each recipe

//creates unique IDs for each recipe
const uuid = Uuid();

// Defines the categories
enum Category { meat, fish, pasta, salad, dessert }

// Defines icons for each category
/*
const categoryIcons = {
  Category.meat: Icons.lunch_dining,
  Category.fish: Icons.flight_takeoff,
  Category.pasta: Icons.movie,
  Category.salad: Icons.work,
  Category.dessert: Icons.work,
}; */

//defines recipe class. Each recipe is assigned a unique ID using UUID.v4()
class Recipe {
  Recipe({
    required this.title,
    required this.instructions,
    required this.ingredients,
    required this.cookingTime,
    required this.category,
    this.imagePath,
    this.photoUrl,
  }) : id = uuid.v4();

  final String id;  // Unique ID for each recipe
  final String title;
  final String instructions;
  final String ingredients;
  final String cookingTime;
  final Category category;
  final String? imagePath; // stores image path - seinna
  final String? photoUrl; // URL for an online photo
}



