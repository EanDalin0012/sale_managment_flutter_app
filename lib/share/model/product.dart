import 'package:flutter/material.dart';

class ProductModel {
  final String name;
  final String remark;
  final String category;
  final String url;

  const ProductModel({
    @required this.name,
    @required  this.remark,
    @required  this.category,
    @required  this.url
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      remark: json['remark'],
      category: json['category'],
      url: json['url'],
    );
  }
    @override
    String toString() {
      return 'ProductModel{name: $name, remark: $remark, category: $category, url: $url}';
    }

}
