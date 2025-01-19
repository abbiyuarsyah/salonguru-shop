import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widgets/product_list_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          tr('product'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: const ProductListWidget(),
    );
  }
}
