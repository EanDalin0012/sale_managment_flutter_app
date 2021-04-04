import 'package:sale_managment/share/model/stock_details_model.dart';

final List<StockDetails> stockDetailsData = [
  StockDetails(
      "Stock A",
      [
        ProductStockDetails('Product A',100,50,1210,100),
        ProductStockDetails('Product B',100,50,1210,100),
        ProductStockDetails('Product C',100,50,1210,100),
        ProductStockDetails('Product D',100,50,1210,100),
        ProductStockDetails('Product E',100,50,1210,100)
      ]
  ),
  StockDetails(
      "Stock B",
      [
        ProductStockDetails('Product A',100,50,1210,100),
        ProductStockDetails('Product B',100,50,1210,100),
        ProductStockDetails('Product C',100,50,1210,100),
        ProductStockDetails('Product D',100,50,1210,100)
      ]
  ),
];
