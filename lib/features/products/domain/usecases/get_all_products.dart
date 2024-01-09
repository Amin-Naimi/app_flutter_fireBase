import '../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failures.dart';
import '../entities/product.dart';

class GetAllProductsUsecase {
  final ProductsRepository repository;

  GetAllProductsUsecase(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getAllProducts();
  }
}
