import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe.dart';

// SearchBarApp widget to display a search bar and filter recipes by query.
class SearchBarApp extends StatefulWidget {
  final List<Recipe> recipes;  // List of recipes to search through.

  const SearchBarApp({super.key, required this.recipes});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  String query = "";  // Store the search input.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),  // Add padding around the entire column.
      child: Column(
        children: [
          // Search bar where the user types the query.
          Container(
            width: double.infinity,  // Make search bar the same width as recipe cards.
            height: 55,  // Set height of search bar.
            decoration: BoxDecoration(
              color: Color(0xFFF1F1F1),  // Light gray background.
              borderRadius: BorderRadius.circular(48),  // Rounded corners.
            ),
            child: TextField(
              onChanged: (String newQuery) {
                setState(() {
                  query = newQuery;  // Update query when user types.
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black38),  // Search icon.
                hintText: 'Search...',  // Placeholder text.
                hintStyle: TextStyle(color: Colors.black38),  // Hint text color.
                border: InputBorder.none,  // No border around text field.
                contentPadding: const EdgeInsets.symmetric(vertical: 15),  // Padding inside the text field.
              ),
            ),
          ),

          // Display filtered search results.
          Expanded(
            child: ListView(
              children: _getFilteredSearchTerms(query).map((term) {
                return ListTile(
                  title: Text(term),  // Display each suggestion.
                  onTap: () {
                    setState(() {
                      query = term;  // Update query when a suggestion is tapped.
                    });
                  },
                );
              }).toList(),  // Convert filtered results to a list of widgets.
            ),
          ),
        ],
      ),
    );
  }

  // Function to filter recipes based on the query.
  List<String> _getFilteredSearchTerms(String query) {
    return widget.recipes
        .map((recipe) => recipe.title)  // Get recipe titles.
        .where((term) => term.toLowerCase().contains(query.toLowerCase()))  // Filter by query.
        .toList();  // Return filtered list.
  }
}
