import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:order_management_flutter_app/features/category/model/category_model.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/responsive.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 120,
        height: Responsive.isMobile(context) ? 60 : 120,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color:
                isSelected ? colors.primary.withOpacity(0.1) : colors.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!Responsive.isMobile(context))
                Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.primary.withOpacity(0.1)
                        : Colors.grey[100]!,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    category.imageUrl,
                    colorFilter: ColorFilter.mode(
                        isSelected ? colors.primary : Colors.grey[500]!,
                        BlendMode.srcIn),
                  ),
                ),
              Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "5 Items",
                style: Theme.of(context).textTheme.bodySmall!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
