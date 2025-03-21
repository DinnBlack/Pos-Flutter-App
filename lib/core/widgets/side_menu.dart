import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/theme.dart';

class SideMenu extends StatefulWidget {
  final Function(int) onTabSelected;
  final int selectedIndex; // Chỉ số menu được chọn

  const SideMenu({
    super.key,
    required this.onTabSelected,
    required this.selectedIndex,
  });

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () => widget.onTabSelected(0),
            isSelected: widget.selectedIndex == 0,
          ),
          DrawerListTile(
            title: "Hoạt động",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () => widget.onTabSelected(1),
            isSelected: widget.selectedIndex == 1,
          ),
          DrawerListTile(
            title: "Inventory",
            svgSrc: "assets/icons/menu_task.svg",
            press: () => widget.onTabSelected(2),
            isSelected: widget.selectedIndex == 2,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.isSelected,
  });

  final String title, svgSrc;
  final VoidCallback press;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      onTap: press,
      horizontalTitleGap: 10,
      tileColor:
          isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : (isDarkMode ? darkSecondaryColor : lightSecondaryColor),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          svgSrc,
          height: 20,
          colorFilter: ColorFilter.mode(
            isSelected
                ? Colors.white
                : (isDarkMode ? Colors.white : Colors.black),
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? Theme.of(context).primaryColor
              : (isDarkMode ? Colors.white : Colors.black),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
