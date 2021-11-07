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
  final List<Product> prooducts;
  Cart({
    @required this.id,
    @required this.status,
    @required this.prooducts,
  });

  Cart copyWith({
    int id,
    CartStatus status,
    List<Product> prooducts,
  }) {
    return Cart(
      id: id ?? this.id,
      status: status ?? this.status,
      prooducts: prooducts ?? this.prooducts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.index,
      'prooducts': prooducts?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      status: CartStatus.values[map['status']],
      prooducts: List<Product>.from(map['prooducts']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, status, prooducts];
}
