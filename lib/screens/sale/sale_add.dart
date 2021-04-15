import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_managment/screens/widgets/contry_dropdown/country_page.dart';
import 'package:sale_managment/screens/widgets/contry_dropdown/flag_widget.dart';
import 'package:sale_managment/screens/widgets/product_dropdown/product_dropdown.dart';
import 'package:sale_managment/share/constant/text_style.dart';
import 'package:sale_managment/share/model/catgory.dart';
import 'package:sale_managment/share/model/country.dart';
import 'package:sale_managment/screens/widgets/package_product_dropdown/package_product_dropdown.dart';
import 'package:sale_managment/share/model/package_product.dart';
import 'package:sale_managment/share/model/product.dart';
import 'package:sale_managment/share/utils/number_format.dart';
class SaleAddScreen extends StatefulWidget {
  @override
  _PackageProductAddState createState() => _PackageProductAddState();
}

class _PackageProductAddState extends State<SaleAddScreen> {

  var borderColorsTextField = Colors.deepPurple;
  var labelStyle = TextStyle(fontSize: 20, color: Colors.deepPurple, fontFamily: fontFamilyDefault);
  var hintStyle = TextStyle(fontFamily: fontFamilyDefault);
  var nameValueController = new TextEditingController();
  var remarkValueController = new TextEditingController();
  var quantityValueController = new TextEditingController();
  var totalValueController = new TextEditingController();
  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
  var textValue = 'Select Product';
  var colorValue = Colors.deepPurple;
  var price;
  var quantity;
  var keyboardType = TextInputType.number;

  Map<String, Object> dropdownValue;
  CountryModel country;
  ProductModel product;
  PackageProductModel packageProductModel;

  var next = 0;
  var btnText = 'Next';

  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: <Widget>[
          _container(),
          SizedBox(height: 15),
          _body(),
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  _save();
                },
                child: Container(
                  width: size.width,
                  height: 45,
                  color: Colors.red,
                  // margin: EdgeInsets.only(
                  //   left: 5,
                  //   right: 5
                  // ),
                  child: Center(child: Text(btnText, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  AppBar _appBar() {
    return AppBar(
        title: Text('Sale', style: TextStyle(fontFamily: 'roboto', fontWeight: FontWeight.w700)),
        backgroundColor: Colors.purple[900]
    );
  }

  Container _container() {
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      padding: EdgeInsets.only(
          left: 10,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              'New Sale',
              style: containStyle
          ),
        ],
      ),
    );
  }

  Expanded _body() {
    return Expanded(
        child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10),
            physics: ClampingScrollPhysics(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: 10,
                        right: 10
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: colorValue, width: 1.5)
                    ),
                    child: ProductDropdown(
                      color: colorValue,
                      onChanged: (value) {
                        setState(() {
                          this.product = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(
                        left: 10,
                        right: 10
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: colorValue, width: 1.5)
                    ),
                    child: PackageProductDropdown(
                      color: colorValue,
                      product: product,
                      packageProduct: packageProductModel,
                      onChanged: (value) {
                        setState(() {
                          this.packageProductModel = value;
                          this.price = this.packageProductModel.price;
                          this.quantityValueController.text = this.packageProductModel.quantity.toString();
                          this.totalValueController.text = _calTotal(price,this.packageProductModel.quantity);
                        });
                      },
                    ),
                  ),
                  price != null ? _buildPrice() : Container(),
                  _nameField(),
                  _quantityField(),
                  _totalField(),
                  _remarkField()
                ])
        )
    );
  }

  Widget _buildPrice() {
    return Container(
        margin: EdgeInsets.only(
            left: 15,
            top: 5
        ),
        child: Text('Price: ${FormatNumber.usdFormat2Digit(this.price)} \$', style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500, fontSize: 15, color: Colors.red.withOpacity(0.8)),));
  }


  Padding _nameField() {
    return Padding(
      padding: EdgeInsets.only(
        right: 10,
        left: 10,
        top: 10
      ),
      child: TextField(
        controller: nameValueController,
        style: styleInput,
        decoration: InputDecoration(
            hintText: 'Enter category name',
            labelText: 'Name',
            // helperText: 'Category Name',
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            // helperStyle: TextStyle(
            //     color: Colors.blueGrey,
            //     fontWeight: FontWeight.bold,
            //     fontFamily: 'roboto'
            // ),
            // border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColorsTextField,
                    width: 1.5,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.5,
                    style: BorderStyle.solid
                )
            ),
            prefixIcon: Icon(
              Icons.info_outline,
              color: Colors.black54,
            )

        ),
      ),
    );
  }

  Padding _quantityField() {
    return Padding(
      padding: EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10
      ),
      child: TextField(
        controller: quantityValueController,
        style: styleInput,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            hintText: 'Enter quantity',
            labelText: 'Quantity',
            // helperText: 'Remark',
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            // helperStyle: TextStyle(
            //     color: Colors.blueGrey,
            //     fontWeight: FontWeight.bold
            // ),
            // border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColorsTextField,
                    width: 1.5,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.5,
                    style: BorderStyle.solid
                )
            ),
            prefixIcon: Icon(
              Icons.info_outline,
              color: Colors.black54,
            ),
        ),
        onChanged: (v) {
          setState(() {
            this.totalValueController.text = _calTotal(price, int.parse(v));
          });
        },
      ),
    );
  }

  Padding _totalField() {
    return Padding(
      padding: EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10
      ),
      child: TextField(
        controller: totalValueController,
        style: styleInput,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            hintText: 'Enter total',
            labelText: 'Total',
            // helperText: 'Remark',
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            // helperStyle: TextStyle(
            //     color: Colors.blueGrey,
            //     fontWeight: FontWeight.bold
            // ),
            // border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColorsTextField,
                    width: 1.5,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.5,
                    style: BorderStyle.solid
                )
            ),
            prefixIcon: Icon(
              Icons.info_outline,
              color: Colors.black54,
            )

        ),
      ),
    );
  }


  Padding _remarkField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: remarkValueController,
        style: styleInput,
        decoration: InputDecoration(
            hintText: 'Enter remark',
            labelText: 'Remark',
            // helperText: 'Remark',
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            // helperStyle: TextStyle(
            //     color: Colors.blueGrey,
            //     fontWeight: FontWeight.bold
            // ),
            // border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: borderColorsTextField,
                    width: 1.5,
                    style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.5,
                    style: BorderStyle.solid
                )
            ),
            prefixIcon: Icon(
              Icons.edit,
              color: Colors.black54,
            )

        ),
      ),
    );
  }

  _save() {
    var categoryModel = new CategoryModel(nameValueController.text, remarkValueController.text);
    print(categoryModel.toString());
  }

  Widget buildSingleCountry() {
    final onTap = () async {
      final country = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CountryPage()),
      );

      if (country == null) return;

      // setState(() => this.country = country);
      // countries.add(this.country);
      // isMultiSelection = true;
    };

    return buildCountryPicker(
      title: 'Select Country',
      child: country == null ? buildListTile(title: 'No Country', onTap: onTap)
          : buildListTile(
        title: country.name,
        leading: FlagWidget(code: country.code),
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

  String _calTotal(int price, int quantity) {
    print('pp: ${price} ${quantity} ');
    if(price> 0 && quantity > 0) {
      print('pp: ');
        return FormatNumber.usdFormat2Digit((price * quantity));
    } else {
      return '0';
    }
  }


}
