import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants.dart';

class TableCreateButton extends StatelessWidget {
  const TableCreateButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colors.secondary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Thêm bàn',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: SvgPicture.asset(
                'assets/icons/add.svg',
                colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
