import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child:  const Row(
        children: [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.indigo,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "AMOTECH",
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
