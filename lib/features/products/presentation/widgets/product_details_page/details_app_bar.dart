import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              GoRouter.of(context).goNamed('product');
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.indigo,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Product",
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
