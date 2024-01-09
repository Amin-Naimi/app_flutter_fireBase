import 'package:dsi32_flutter_project/features/products/presentation/blocs/landingPageBloc/landing_page_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/pages/add_product_page.dart';
import 'package:dsi32_flutter_project/features/products/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingPageBloc, LandingPageState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.tabIndex,
          onTap: (index) {
            context.read<LandingPageBloc>().add(TabChange(tabIndex: index));

            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductPage(),
                ),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddProductPage(isUpdateProduct: false),
                ),
              );
            }
          },
          selectedItemColor: Colors.indigo,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded),
              label: 'New Product',
            ),
          ],
          selectedFontSize: 12.0,
        );
      },
    );
  }
}
