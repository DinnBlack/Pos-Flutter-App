import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:order_management_flutter_app/features/category/repository/category_data.dart';
import 'package:order_management_flutter_app/features/product/views/product_create_button.dart';

import '../../category/model/category_model.dart';

class ProductInventoryFilter extends StatefulWidget {
  final Function(String?) onCategorySelected;
  final Function(String) onSortOptionSelected;

  const ProductInventoryFilter({
    super.key,
    required this.onCategorySelected,
    required this.onSortOptionSelected,
  });

  @override
  State<ProductInventoryFilter> createState() => _ProductInventoryFilterState();
}

class _ProductInventoryFilterState extends State<ProductInventoryFilter> {
  String selectedCategory = '';
  String selectedSortOption = 'Mặc định';

  final List<String> sortOptions = [
    'Mặc định',
    'Giá tăng dần',
    'Giá giảm dần',
    'Tên A-Z',
    'Tên Z-A',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final List<CategoryModel> categories = [
      CategoryModel(
          id: '',
          name: "Tất cả",
          description: '',
          imageUrl: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()),
      ...demoCategories,
    ];

    return Row(
      children: [
        // Dropdown Sắp xếp
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: selectedSortOption,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedSortOption = newValue;
                });
                widget.onSortOptionSelected(newValue);
              }
            },
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              decoration: BoxDecoration(
                color: colors.secondary,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              elevation: 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: colors.onPrimary,
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down,
              ),
            ),
            items: sortOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
          ),
        ),
        const SizedBox(width: 10),

        // Dropdown Lọc theo danh mục
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue ?? '';
              });
              widget.onCategorySelected(newValue);
            },
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              decoration: BoxDecoration(
                color: colors.secondary,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              elevation: 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: colors.onPrimary,
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down,
              ),
            ),
            items: categories.map((CategoryModel category) {
              return DropdownMenuItem<String>(
                value: category.id,
                child:
                    Text(category.name, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
