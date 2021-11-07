import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Product extends Equatable {
  final int id;
  final String sku;
  final String name;
  final String image;
  final String description;
  final int stock;
  final int quantity;

  Product({
    @required this.id,
    @required this.sku,
    @required this.name,
    @required this.image,
    @required this.description,
    @required this.stock,
    @required this.quantity,
  });

  Product copyWith({
    int id,
    String sku,
    String name,
    String image,
    String description,
    int stock,
    int quantity,
  }) {
    return Product(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      stock: stock ?? this.stock,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sku': sku,
      'name': name,
      'image': image,
      'description': description,
      'stock': stock,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      sku: map['sku'],
      name: map['name'],
      image: map['image'],
      description: map['description'],
      stock: map['stock'],
      quantity: map['quantity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, sku: $sku, name: $name, image: $image, description: $description, stock: $stock, quantity: $quantity)';
  }

  @override
  List<Object> get props {
    return [
      id,
      sku,
      name,
      image,
      description,
      stock,
      quantity,
    ];
  }
}
