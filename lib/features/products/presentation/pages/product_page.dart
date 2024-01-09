import 'package:dsi32_flutter_project/core/widgets/loading_widget.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/productBloc/product_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/widgets/bottom_navigation_bar.dart';
import 'package:dsi32_flutter_project/features/products/presentation/widgets/message_display_widget.dart';
import 'package:dsi32_flutter_project/features/products/presentation/widgets/product_page/app_bar.dart';
import 'package:dsi32_flutter_project/features/products/presentation/widgets/product_page/products_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return ListView(
          children: [
            const HomeAppBar(),
            Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                color: Color(0xFFEDECF2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "search here ..."),
                        ),
                      )
                    ]),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: const Text(
                      "Our Products",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                  ),
                  _buildProductsItems(state, context),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductsItems(ProductState state, BuildContext context) {
    if (state is LoadingProductsState) {
      return const LoadingWidget();
    } else if (state is LoadedProductsState) {
      return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: ProductsItemsWidget(
            products: state.products,
          ));
    } else if (state is ErrorProductState) {
      return MessageDisplayWidget(message: state.message);
    } else {
      return const LoadingWidget();
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<ProductBloc>(context).add(RefreshProductsEvent());
  }
}
