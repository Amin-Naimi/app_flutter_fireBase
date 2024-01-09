import 'package:dsi32_flutter_project/config/go_router_config.dart';
import 'package:dsi32_flutter_project/core/utils/snackbar_message.dart';
import 'package:dsi32_flutter_project/core/widgets/loading_widget.dart';
import 'package:dsi32_flutter_project/features/products/domain/entities/product.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/addUpdateDeleteBloc/add_update_delete_product_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/landingPageBloc/landing_page_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/productBloc/product_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/pages/product_page.dart';
import 'package:dsi32_flutter_project/features/products/presentation/widgets/add_product_page/product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/bottom_navigation_bar.dart';

class AddProductPage extends StatelessWidget {
  final Product? product;
  final bool isUpdateProduct;
  const AddProductPage({Key? key, this.product, required this.isUpdateProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(isUpdateProduct),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      title: Text(isUpdateProduct ? "Update Product" : "Add New Product"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.read<LandingPageBloc>().add(TabChange(tabIndex: 0));
          if (isUpdateProduct == false) {
            Navigator.pop(context);
          } else {
          //  router.go("/products");
          }
        },
      ),
    );
  }

  Widget _buildBody(bool isUpdateProduct) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<AddUpdateDeleteProductBloc,
              AddUpdateDeleteProductState>(
            listener: (context, state) {
              if (state is MessageAddUpdateDeleteProductState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                if (isUpdateProduct == true) {
                  context.go("/products");
                } else {
                  Navigator.pop(context);
                }

                BlocProvider.of<ProductBloc>(context)
                    .add(RefreshProductsEvent());
              } else if (state is ErrorAddUpdateDeleteProductState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddUpdateDeleteProductState) {
                return const LoadingWidget();
              }

              return AddProductForm(
                  isUpdateProduct: isUpdateProduct,
                  myProduct: isUpdateProduct ? product : null);
            },
          )),
    );
  }
}
