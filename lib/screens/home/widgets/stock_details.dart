
import 'package:flutter/material.dart';
import 'package:sale_managment/share/model/stock_details_model.dart';

class StockDetailsScreen extends StatefulWidget {
  final List<ProductStockDetails> productStockDetails;
  StockDetailsScreen(this.productStockDetails);

  @override
  _StockDetailsState createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:4,
              itemBuilder: (context,index){
                return  Row(
                  children: widget.productStockDetails.map((e) => production(e)).toList(),
                );
              })
        ],
      ),
    );
  }

  Container production(ProductStockDetails productStockDetails) {
    final TextStyle stats = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white);
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "+500",
            style: stats,
          ),
          const SizedBox(height: 5.0),
          Text(productStockDetails.productName.toString())
        ],
      ),
    );
  }
}
