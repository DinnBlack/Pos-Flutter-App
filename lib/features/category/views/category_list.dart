import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/responsive.dart';
import '../model/category_model.dart';
import '../repository/category_data.dart';
import 'category_list_item.dart';

class MyCategories extends StatelessWidget {
  final Function(String?) onCategorySelected;

  const MyCategories({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: CategoryList(onCategorySelected: onCategorySelected),
      tablet: CategoryList(onCategorySelected: onCategorySelected),
      desktop: CategoryList(onCategorySelected: onCategorySelected),
    );
  }
}

class CategoryList extends StatefulWidget {
  final Function(String?) onCategorySelected;

  const CategoryList({super.key, required this.onCategorySelected});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        selectedIndex = 0;
      });
      widget.onCategorySelected(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.isMobile(context) ? 60 : 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: demoCategories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.only(
                  left: Responsive.isMobile(context) ? defaultPadding : 0,
                  right: defaultPadding),
              child: CategoryListItem(
                category: CategoryModel(
                    id: '',
                    name: "Tất cả",
                    description: '',
                    imageUrl: "assets/icons/category_all.svg",
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now()),
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  widget.onCategorySelected(null);
                },
              ),
            );
          } else {
            final category = demoCategories[index - 1];
            return Padding(
              padding: const EdgeInsets.only(right: defaultPadding),
              child: CategoryListItem(
                category: category,
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  widget.onCategorySelected(category.id);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
