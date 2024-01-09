import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProductUsecase {
  final ProductsRepository repository;

  AddProductUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Product product) async {
    return await repository.addProduct(product);
  }
}
