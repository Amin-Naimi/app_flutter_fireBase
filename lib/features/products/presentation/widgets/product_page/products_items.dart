import 'dart:developer';

import 'package:dsi32_flutter_project/core/utils/snackbar_message.dart';
import 'package:dsi32_flutter_project/core/widgets/loading_widget.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/addUpdateDeleteBloc/add_update_delete_product_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/landingPageBloc/landing_page_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/productBloc/product_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/pages/product_page.dart';
import 'package:dsi32_flutter_project/features/products/domain/entities/product.dart';
import 'package:dsi32_flutter_project/features/products/presentation/pages/product_details_page.dart';
import 'package:dsi32_flutter_project/features/products/presentation/widgets/product_page/delete_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductsItemsWidget extends StatelessWidget {
  final List<Product> products;
  ProductsItemsWidget({
    Key? key,
    required this.products,
  }) : super(key: key) {
    printProduct();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (int i = 0; i < products.length; i++)
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "-${products[i].discountPercentage}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
 /****************************************************************************************************/                
                  onTap: () {
                           GoRouter.of(context).goNamed('detailsproduct',extra: products[i]);
                  },
 /****************************************************************************************************/                


                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 120,
                    width: 120,
                    child: Image.asset("assets/images/1.png"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    products[i].title.toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${products[i].price} DT",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo),
                      ),
                      // Delete buttons
                      IconButton(
                        onPressed: () {
                          deleteDialog(context, products[i].id!);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 69, 75, 109),
                        ),
                      )
                      // End Delete buttons
                    ],
                  ),
                )
              ],
            ),
          )
      ],
    );
  }

  void deleteDialog(BuildContext context, String productId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddUpdateDeleteProductBloc,
              AddUpdateDeleteProductState>(
            // Listeners
            listener: (context, state) {
              if (state is MessageAddUpdateDeleteProductState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
            GoRouter.of(context).pushNamed('product');

                // To handel the refresh nd multi snack bar that appears
                if (state is! LoadingAddUpdateDeleteProductState) {
                  BlocProvider.of<ProductBloc>(context)
                      .add(RefreshProductsEvent());
                }
              } else if (state is ErrorAddUpdateDeleteProductState) {
            GoRouter.of(context).pushNamed('product');
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            // Builder
            builder: (context, state) {
              if (state is LoadingAddUpdateDeleteProductState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(
                productId: productId,
              );
            },
          );
        });
  }

  void printProduct() {
    for (int i = 0; i < products.length; i++) {
      log("Product $i: ${products[i].toString()}");
    }
  }
}
