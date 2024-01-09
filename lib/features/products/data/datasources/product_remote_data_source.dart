import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<Unit> deleteProduct(String productId);
  Future<Unit> updateProduct(ProductModel productModel);
  Future<Unit> addProduct(ProductModel productModel);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final QuerySnapshot querySnapshot =
          await firestore.collection('products').get();

      final List<ProductModel> productModels = querySnapshot.docs
          .map<ProductModel>(
              (documentSnapshot) => ProductModel.fromDocument(documentSnapshot))
          .toList();

      return productModels;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addProduct(ProductModel productModel) async {
    try {
      final DocumentReference docRef =
          await firestore.collection('products').add(productModel.toDocument() as Map<String, dynamic>);
      final String productId = docRef.id;

      final ProductModel updatedProductModel = ProductModel(
        id: productId,
        title: productModel.title,
        description: productModel.description,
        price: productModel.price,
        discountPercentage: productModel.discountPercentage,
        //image: productModel.image!,
      );
      await docRef.set(updatedProductModel.toDocument());

      return unit;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteProduct(String productId) async {
    try {
      await firestore.collection('products').doc(productId).delete();
      return unit;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateProduct(ProductModel productModel) async {
    try {
      log("update methode fire base:" + productModel.id!);
      await firestore
          .collection('products')
          .doc(productModel.id.toString())
          .update(productModel.toDocument() as Map<Object, Object?>);
      return unit;
    } catch (e) {
      throw ServerException();
    }
  }
}
