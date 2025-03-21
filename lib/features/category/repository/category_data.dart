import '../model/category_model.dart';

List<CategoryModel> demoCategories = [
  CategoryModel(
    id: "1",
    name: "Bít tết",
    description: "Các món bò bít tết thơm ngon, mềm mọng, phù hợp với khẩu vị Á - Âu.",
    imageUrl: "assets/icons/category_meat.svg",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    id: "2",
    name: "Món ăn kèm",
    description: "Các món ăn phụ như khoai tây chiên, bánh mì bơ tỏi, rau củ hấp.",
    imageUrl: "assets/icons/category_french_fries.svg",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    id: "3",
    name: "Salad",
    description: "Các món salad tươi ngon với rau xanh, sốt đặc biệt, và topping hấp dẫn.",
    imageUrl: "assets/icons/category_salad.svg",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    id: "4",
    name: "Thức uống",
    description: "Nhiều lựa chọn thức uống như cà phê, trà sữa, nước ép trái cây, sinh tố.",
    imageUrl: "assets/icons/category_drink.svg",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
