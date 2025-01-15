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
            width: double.infinity,  // Make the search bar the same width as the recipe cards.
            height: 55,  // Set height of the search bar.
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),  // Light gray background.
              borderRadius: BorderRadius.circular(48),  // Rounded corners.
            ),
            child: TextField(
              onChanged: (String newQuery) {
                setState(() {
                  query = newQuery;  // Update query when the user types in the search bar.
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.black38),  // Search icon.
                hintText: 'Search...',  // Placeholder text inside the search bar.
                hintStyle: TextStyle(color: Colors.black38),  // Style of the hint text.
                border: InputBorder.none,  // No border around the text field.
                contentPadding: EdgeInsets.symmetric(vertical: 15),  // Padding inside the text field.
              ),
            ),
          ),

          // Display filtered search results based on the search query.
          Expanded(
            child: ListView(
              children: _getFilteredSearchTerms(query).map((term) {
                return ListTile(
                  title: Text(term),  // Display each search term as a list item.
                  onTap: () {
                    setState(() {
                      query = term;  // Update the query when a suggestion is tapped.
                    });
                  },
                );
              }).toList(),  // Convert filtered results to a list of widgets (ListTile).
            ),
          ),
        ],
      ),
    );
  }

  // Function to filter recipes based on the query.
  List<String> _getFilteredSearchTerms(String query) {
    return widget.recipes
        .map((recipe) => recipe.title)  // Get all recipe titles from the list of recipes.
        .where((term) => term.toLowerCase().contains(query.toLowerCase()))  // Filter the list by checking if the query is a substring of each title.
        .toList();  // Return the filtered list as a new list of matching titles.
  }
}
