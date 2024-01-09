import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dsi32_flutter_project/core/exceptions/failures.dart';
import 'package:dsi32_flutter_project/core/strings/failures.dart';
import 'package:dsi32_flutter_project/core/strings/messages.dart';
import 'package:dsi32_flutter_project/features/products/domain/entities/product.dart';
import 'package:dsi32_flutter_project/features/products/domain/usecases/add_product.dart';
import 'package:dsi32_flutter_project/features/products/domain/usecases/delete_product.dart';
import 'package:dsi32_flutter_project/features/products/domain/usecases/update_product.dart';
import 'package:equatable/equatable.dart';

part 'add_update_delete_product_event.dart';
part 'add_update_delete_product_state.dart';

class AddUpdateDeleteProductBloc
    extends Bloc<AddUpdateDeleteProductEvent, AddUpdateDeleteProductState> {
  final AddProductUsecase addProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;
  final UpdateProductUsecase updateProductUsecase;

  AddUpdateDeleteProductBloc({
    required this.addProductUsecase,
    required this.deleteProductUsecase,
    required this.updateProductUsecase,
  }) : super(AddUpdateDeleteProductInitial()) {
    on<AddUpdateDeleteProductEvent>((event, emit) async {
      if (event is AddProductEvent) {
        emit(LoadingAddUpdateDeleteProductState());
        final failureOrDoneMessage = await addProductUsecase(event.product);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } 
      else if (event is UpdateProductEvent) {
        emit(LoadingAddUpdateDeleteProductState());
        final failureOrDoneMessage = await updateProductUsecase(event.product);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeleteProductEvent) {
        emit(LoadingAddUpdateDeleteProductState());
        final failureOrDoneMessage =
            await deleteProductUsecase(event.productId);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddUpdateDeleteProductState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddUpdateDeleteProductState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddUpdateDeleteProductState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Erreur inconnue. Veuillez réessayer plus tard";
    }
  }
}
