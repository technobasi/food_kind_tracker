enum MealType {
  VEGGIE,
  VEGAN,
  OMNI;

  static valueOf(String? name) {
    switch(name) {
      case "VEGGIE":
        return MealType.VEGGIE;
      case "VEGAN":
        return MealType.VEGAN;
      case "OMNI":
        return MealType.OMNI;
      default:
        return null;
    }
  }
}