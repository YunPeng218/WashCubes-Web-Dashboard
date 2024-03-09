import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class OperatorSideMenu extends StatelessWidget {
  const OperatorSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF182738),
          ),
          child: const NavBarItem(text: 'All Orders', color: Colors.white),
        ),
        const NavBarItem(text: 'Pending'),
        const NavBarItem(text: 'Process'),
        const NavBarItem(text: 'Error'),
        const NavBarItem(text: 'Ready'),
        const NavBarItem(text: 'Returned'),
        const Spacer(),
        Container(
          width: double.infinity,
          color: const Color(0xFF182738),
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String text;
  final Color? color;

  const NavBarItem({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Text(
          text,
          style: CTextTheme.blackTextTheme.displaySmall,
        ),
      ),
    );
  }
}