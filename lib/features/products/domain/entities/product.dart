//import 'dart:io';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  //final File? image;


  const Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
   // required this.image
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      price,
      discountPercentage,
     // image
    ];
  }
}
