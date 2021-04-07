import 'package:flutter/material.dart';
import 'package:sale_managment/share/model/stock_details_model.dart';

class ProductCard extends StatefulWidget {

  final ProductStockDetails productStockDetails;
  ProductCard(this.productStockDetails);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final TextStyle stats = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black54);
  final TextStyle stats1 = TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0, color: Colors.black54);
  var textStyle = TextStyle(color: Colors.black54,fontSize: 18.0,fontWeight: FontWeight.w700, fontFamily: 'roboto, khmer siemreap');
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      decoration:
      BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.1), width: 2),
          boxShadow: [
            BoxShadow(color: Colors.deepPurpleAccent.withOpacity(0.4),offset: Offset(0,8), blurRadius: 10)
          ]),
      child: Container(
        margin: EdgeInsets.only(left: 2),
        padding: EdgeInsets.all(10),
        child: Column(

          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.productStockDetails.productName , style: textStyle),
                Text(widget.productStockDetails.totalQuantity.toString(),style: stats),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Quantity: - '+widget.productStockDetails.soldQuantity.toString() , style: textStyle)
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Price: '+widget.productStockDetails.price.toString()+' USD' , style: textStyle)
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Total: '+widget.productStockDetails.total.toString() +' USD' , style: textStyle)
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Net Income: '+widget.productStockDetails.netIncome.toString() +' USD' , style: textStyle)
              ],
            ),
          ],
        )
      ),
    );
  }
}
