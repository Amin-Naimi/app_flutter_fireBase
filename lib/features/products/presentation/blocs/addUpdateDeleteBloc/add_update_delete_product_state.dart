part of 'add_update_delete_product_bloc.dart';

sealed class AddUpdateDeleteProductState extends Equatable {
  const AddUpdateDeleteProductState();
  
  @override
  List<Object> get props => [];
}

final class AddUpdateDeleteProductInitial extends AddUpdateDeleteProductState {}

class LoadingAddUpdateDeleteProductState extends AddUpdateDeleteProductState {}

class ErrorAddUpdateDeleteProductState extends AddUpdateDeleteProductState {
  final String message;
  ErrorAddUpdateDeleteProductState({required this.message});
  @override
  List<Object> get props => [message];
}

class MessageAddUpdateDeleteProductState extends AddUpdateDeleteProductState {
  final String message;
  MessageAddUpdateDeleteProductState({required this.message});
  @override
  List<Object> get props => [message];
}
