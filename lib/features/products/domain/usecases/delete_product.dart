import '../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/failures.dart';

class DeleteProductUsecase {
  final ProductsRepository repository;

  DeleteProductUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String productId) async {
    return await repository.deleteProduct(productId);
  }
}
