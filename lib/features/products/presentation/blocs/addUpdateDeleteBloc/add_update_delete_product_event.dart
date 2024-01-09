part of 'add_update_delete_product_bloc.dart';

sealed class AddUpdateDeleteProductEvent extends Equatable {
  const AddUpdateDeleteProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends AddUpdateDeleteProductEvent {
  final Product product;
  AddProductEvent({required this.product});
  @override
  List<Object> get props => [product];
}

class UpdateProductEvent extends AddUpdateDeleteProductEvent {
  final Product product;
  UpdateProductEvent({required this.product});
  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends AddUpdateDeleteProductEvent {
  final String productId;
  DeleteProductEvent({required this.productId});
  @override
  List<Object> get props => [productId];
}