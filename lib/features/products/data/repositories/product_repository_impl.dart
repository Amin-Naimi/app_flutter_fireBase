import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/exceptions/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final remoteProducts = await remoteDataSource.getAllProducts();
      return Right(remoteProducts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addProduct(Product product) async {
    final ProductModel productModel = ProductModel(
      title: product.title,
      description: product.description,
      price: product.price,
      discountPercentage: product.discountPercentage,
      //image: product.image!,
    );

    return await _getMessage(() {
      return remoteDataSource.addProduct(productModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String productId) async {
    return await _getMessage(() {
      return remoteDataSource.deleteProduct(productId.toString());
    });
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(Product product) async {
    log("calling");
    final ProductModel productModel = ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      discountPercentage: product.discountPercentage,
      //image: product.image!,
    );
    log("calling 2 "+ productModel.toString());

    return await _getMessage(() {
      return remoteDataSource.updateProduct(productModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      Future<Unit> Function() deleteOrUpdateOrAddProduct) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddProduct();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
