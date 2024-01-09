

import '../../../../core/exceptions/failures.dart';
import '../entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Unit>> deleteProduct(String id);
  Future<Either<Failure, Unit>> updateProduct(Product product);
  Future<Either<Failure, Unit>> addProduct(Product product);
}
