import 'package:dsi32_flutter_project/features/products/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';

class FormAppBar extends StatelessWidget {
  const FormAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
                   Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProductPage(),
              ),
            );
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.indigo,
            ),
          ), const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Add Product",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
          ),
         
        ],
      ),
    );
  }
}
