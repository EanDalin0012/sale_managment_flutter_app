
import 'package:flutter/material.dart';
import 'package:sale_managment/share/model/product.dart';
import 'package:sale_managment/screens/widgets/product_dropdown/FlagImageWidget.dart';

class ProductListTileWidget extends StatelessWidget {
  final ProductModel productModel;
  final bool isNative;
  final bool isSelected;
  final ValueChanged<ProductModel> onSelectedProduct;

  const ProductListTileWidget({
    Key key,
    @required this.productModel,
    @required this.isNative,
    @required this.isSelected,
    @required this.onSelectedProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    return ListTile(
        onTap: () => onSelectedProduct(productModel),
        leading: FlagImageWidget(
          width: 40,
          height: 40,
          url: productModel.url,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            border: Border.all(color: Colors.grey, width: 2),
          ),
        ),
        title: Text(productModel.name),
         trailing: isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
