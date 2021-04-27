import 'package:flutter/material.dart';
import 'package:sale_managment/screens/product/widget/product_body.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text("Product"),
      ),
      body: ProductBody(),
    );
  }
}
