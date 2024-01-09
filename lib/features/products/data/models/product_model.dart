  import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsi32_flutter_project/core/exceptions/exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    String? id,
    required String title,
    required String description,
    required double price,
    required double discountPercentage,
    //required File image,
  }) : super(
            id: id,
            title: title,
            description: description,
            price: price,
            discountPercentage: discountPercentage,
           // image: image
            );

  factory ProductModel.fromDocument(DocumentSnapshot documentSnapshot) {
    return ProductModel(
        id: documentSnapshot.get('id'),
        title: documentSnapshot.get('title'),
        description: documentSnapshot.get('description'),
        price: documentSnapshot.get('price'),
        discountPercentage: documentSnapshot.get('discountPercentage'),
        //image: File(documentSnapshot.get('imagePath') ?? '')
        );
  }

  Map<String, dynamic> toDocument() {
    Map<String, dynamic> document = {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
    };
     /* uploadeImage(image!).then((imageUrl) {
        document['imageUrl'] = imageUrl;
      });*/
    
    return document;
  }

  /*Future<String> uploadeImage(File image) async {
    try {
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');
      String imageName = basename(image.path);
      Reference referenceImageToUpload = referenceDirImages.child(imageName);
      await referenceImageToUpload.putFile(File(image.path));
      String imageUrl = await referenceImageToUpload.getDownloadURL();
      log(imageUrl);
      return imageUrl;
    } catch (error) {
      throw ServerException();
    }
  }*/
}