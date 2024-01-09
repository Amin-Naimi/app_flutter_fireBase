import 'package:dsi32_flutter_project/features/products/presentation/blocs/addUpdateDeleteBloc/add_update_delete_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeleteDialogWidget extends StatelessWidget {
  final String productId;

  const DeleteDialogWidget({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        // Wrap Row in Column
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning,
                color: Color.fromARGB(255, 47, 42, 42),
              ),
              SizedBox(width: 16), // Adjust the spacing as needed
            ],
          ),
          Text("Are you sure you want to delete this product?"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).pushNamed('product');
          },
          child: const Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddUpdateDeleteProductBloc>(context).add(
              DeleteProductEvent(productId: productId),
            );
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
