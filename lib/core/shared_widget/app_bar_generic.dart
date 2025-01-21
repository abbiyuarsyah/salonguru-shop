import 'package:flutter/material.dart';

class AppBarGeneric extends StatelessWidget implements PreferredSizeWidget {
  const AppBarGeneric({
    super.key,
    required this.title,
    required this.centerTitle,
    this.actions,
    this.automaticallyImplyLeading,
  });

  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool? automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
