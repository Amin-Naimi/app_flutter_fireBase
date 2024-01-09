import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dsi32_flutter_project/core/exceptions/failures.dart';
import 'package:dsi32_flutter_project/core/strings/failures.dart';
import 'package:dsi32_flutter_project/features/products/domain/usecases/get_all_products.dart';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUsecase getAllProducts;
  ProductBloc({
    required this.getAllProducts,
  }) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetAllProductsEvent) {
        emit(LoadingProductsState());
        final failureOrProducts = await getAllProducts();
        emit(_mapFailureOrPostsToState(failureOrProducts));
      } 
      else if (event is RefreshProductsEvent) {
        emit(LoadingProductsState());
        final failureOrPosts = await getAllProducts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  ProductState _mapFailureOrPostsToState(
      Either<Failure, List<Product>> either) {
    return either.fold(
      (failure) => ErrorProductState(message: _mapFailureToMessage(failure)),
      (products) => LoadedProductsState(
        products: products,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
