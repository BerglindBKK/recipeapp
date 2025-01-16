//recipe data stored in "registered expenses" list
//two hardcoded dummy cases
import 'package:recipeapp/models/recipe.dart';

class RecipeData {
  static final List<Recipe> registeredRecipes = [
    Recipe(
      title: 'Rúlluterta með ostasósu',
      ingredients: 'rúlla, terta, ostur, sósa',
      instructions: 'baka og borða',
      cookingTime: '40',
      category: Category.dessert,
      imagePath: 'assets/images/rulluterta.jpg'
    ),
    Recipe(
      title: 'Pasta með sinnepi',
      ingredients: 'pasta, sinnep',
      instructions: 'sjóða pasta, sprauta sinnepi yfir',
      cookingTime: '10',
      category: Category.pasta,
      imagePath: 'assets/images/pasta.jpg'
    ),
    Recipe(
      title: 'Spergilkál með remúlaði',
      ingredients: 'broccoli, remúlaði',
      instructions: 'gufusjóða spergilkálið, blanda saman við remúlaði',
      cookingTime: '10',
      category: Category.salad,
      imagePath: 'assets/images/broccoli.jpg'
    ),
    Recipe(
      title: 'Rækjusalat með tómatsósu',
      ingredients: 'rækjusalat, tómatsósa',
      instructions: 'hellið rækjusalatinu úr dósinni, blandið saman með tímatsósu',
      cookingTime: '2',
      category: Category.fish,
      imagePath: 'assets/images/raekjur.jpg'
    ),
    Recipe(
        title: 'pulsa með sýrðum rjóma',
        ingredients: 'pulsa, sýrður rjómi',
        instructions: 'sjóða pulsu, dýfa í sýrðan rjóma',
        cookingTime: '10',
        category: Category.meat,
        imagePath: 'assets/images/hotdog.jpg'
    ),
  ];
}

// This function returns the default image for each category
String getCategoryDefaultImage(Category category) {
  switch (category) {
    case Category.meat:
      return 'assets/images/default_meat.png';
    case Category.fish:
      return 'assets/images/default_fish.png';
    case Category.pasta:
      return 'assets/images/default_pasta.png';
    case Category.salad:
      return 'assets/images/default_salad.png';
    case Category.dessert:
      return 'assets/images/default_dessert.png';

  }
}
