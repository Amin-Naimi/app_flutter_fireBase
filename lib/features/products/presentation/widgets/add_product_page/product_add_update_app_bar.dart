import 'package:dsi32_flutter_project/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductAddUpdateAppBar extends StatelessWidget {
  final Product? product;
  final bool isUpdateProduct;
  ProductAddUpdateAppBar({
    Key? key,
   this.product,
   required this.isUpdateProduct
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(40),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              isUpdateProduct ?
              context.go("/detailsProduct", extra: product)
              : context.go("/products");
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.indigo,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              isUpdateProduct ? "Update Product" : "Add Product",
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
