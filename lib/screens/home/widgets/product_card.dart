import 'package:flutter/material.dart';
import 'package:sale_managment/share/model/stock_details_model.dart';

class ProductCard extends StatefulWidget {

  final ProductStockDetails productStockDetails;
  ProductCard(this.productStockDetails);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      decoration:
      BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 8
            )
          ]),
      child: Container(
        margin: EdgeInsets.only(left: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.productStockDetails.productName),
            Text(widget.productStockDetails.productName)
          ],
        )
      ),
    );
  }
}
