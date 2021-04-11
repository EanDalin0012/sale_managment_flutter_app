import 'package:flutter/material.dart';
import 'package:sale_managment/screens/widgets/product_dropdown/product_page.dart';
import 'package:sale_managment/share/model/product.dart';
import 'package:sale_managment/screens/widgets/product_dropdown/FlagImageWidget.dart';

class ProductDropdown extends StatefulWidget {
  @override
  _ProductDropdownState createState() => _ProductDropdownState();
}

class _ProductDropdownState extends State<ProductDropdown> {
  ProductModel product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
        child: buildSingleProduct(),
      );
  }

  Widget buildSingleProduct() {
    final onTap = () async {
      final product = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductPage(
          productModel: this.product,
        )),
      );

      if (product == null) return;
      setState(() {
        this.product = product;
      });
    };

    return buildCountryPicker(
      title: 'Select Country',
      child: product == null? buildListTile(title: 'No Country', onTap: onTap)
          : buildListTile(
        title: product.name,
        leading: FlagImageWidget(
          width: 40,
          height: 40,
          url: product.url,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            border: Border.all(color: Colors.grey, width: 2),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildListTile({
    @required String title,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }

  Widget buildCountryPicker({
    @required String title,
    @required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );

  Widget buildLeading(String url) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundImage:NetworkImage(url),
        backgroundColor: Colors.transparent,
      ),
    );
  }

}
