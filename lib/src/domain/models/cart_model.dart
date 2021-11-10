import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:soytul/src/domain/models/product_model.dart';

enum CartStatus {
  PENDING,
  COMPLETED,
}

class Cart extends Equatable {
  final int id;
  final CartStatus status;
  final List<Product> products;
  Cart({
    @required this.id,
    @required this.status,
    @required this.products,
  });

  Cart copyWith({
    int id,
    CartStatus status,
    List<Product> products,
  }) {
    return Cart(
      id: id ?? this.id,
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.index,
      'products': products?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    List<Product> _products = [];
    if(map['products'] != null) {
      _products = List<Product>.from(map['products']?.map((x) => Product.fromMap(x)));
    }

    return Cart(
      id: map['id'],
      status: CartStatus.values[map['status']],
      products: _products,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, status, products];
}
