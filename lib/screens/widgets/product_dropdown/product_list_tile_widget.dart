
import 'package:flutter/material.dart';
import 'package:sale_managment/share/model/product.dart';

class ProductListTileWidget extends StatelessWidget {
  final ProductModel productModel;
  final bool isNative;
  final bool isSelected;
  final ValueChanged<ProductModel> onSelectedCountry;

  const ProductListTileWidget({
    Key key,
    @required this.productModel,
    @required this.isNative,
    @required this.isSelected,
    @required this.onSelectedCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(productModel.toString());
    return ListTile(
        title: Text('Hello'),
    );
  }
}
