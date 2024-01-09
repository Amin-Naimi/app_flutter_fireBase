import 'package:dsi32_flutter_project/features/products/presentation/blocs/landingPageBloc/landing_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
              GoRouter.of(context).pushNamed('product');
            } else if (index == 1) {
              GoRouter.of(context).pushNamed('addproduct',extra: false);
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
