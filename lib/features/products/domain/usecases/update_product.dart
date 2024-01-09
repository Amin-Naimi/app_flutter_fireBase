import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProductUsecase {
  final ProductsRepository repository;

  UpdateProductUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Product product) async {
    log("use case update product " + product.toString());
    return await repository.updateProduct(product);
  }
}
