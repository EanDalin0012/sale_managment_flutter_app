import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_managment/screens/widgets/contry_dropdown/country_page.dart';
import 'package:sale_managment/screens/widgets/contry_dropdown/flag_widget.dart';
import 'package:sale_managment/screens/widgets/product_dropdown/product_dropdown.dart';
import 'package:sale_managment/share/constant/text_style.dart';
import 'package:sale_managment/share/model/catgory.dart';
import 'package:sale_managment/share/model/country.dart';
import 'package:sale_managment/screens/widgets/package_product_dropdown/package_product_dropdown.dart';
import 'package:sale_managment/share/model/key/transactionKey.dart';
import 'package:sale_managment/share/model/package_product.dart';
import 'package:sale_managment/share/model/product.dart';
import 'package:sale_managment/share/utils/number_format.dart';
import 'package:sale_managment/screens/sale/widgets/sale_items.dart';

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
  var cartArrowDownCount = 0 ;
  double price;
  double quantity;
  var keyboardType = TextInputType.number;

  Map<String, Object> dropdownValue;
  CountryModel country;
  ProductModel product;
  PackageProductModel packageProductModel;

  var next = 0;
  var btnText = 'Next';
  List<dynamic> vData = [];

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
                  setState(() {
                    this.next += 1;
                  });
                },
                child: Container(
                  width: size.width,
                  height: 45,
                  color: Colors.red,
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
        backgroundColor: Colors.purple[900],
        actions: <Widget>[
          InkWell(
            onTap: () {
              _showModelSheet();
            },
            child: Container(
              height: 80,
              width: 55,
              child: Stack(
                children: <Widget>[
                  Center(child:  FaIcon(FontAwesomeIcons.cartArrowDown,size: 25 , color: Colors.white,),),
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(
                        top: 5,
                        left: 30
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(child: Text(cartArrowDownCount.toString(), style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800))),
                  ),
                ],
              ),
            ),
          ),
        ]
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
                      product: this.product,
                      onChanged: (value) {
                        setState(() {
                          this.product = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  next > 0 ? Container(
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
                          this.price = double.parse(this.packageProductModel.price.toString());
                          this.quantityValueController.text = this.packageProductModel.quantity.toString();
                          this.totalValueController.text = _calTotal(double.parse(price.toString()),double.parse(this.packageProductModel.quantity.toString()));
                        });
                      },
                    ),
                  ) : Container(),
                  (next > 0) && price != null ? _buildPrice() : Container(),
                  // next > 0 ? _nameField(): Container() ,
                  next > 0 ? _quantityField() : Container(),
                  next > 0 ? _totalField() : Container(),
                  SizedBox(height: 15,),
                  // next > 0 ? _remarkField() : Container(),
                  if (next > 0) Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[_buildAddButton()]) else Container()
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
              if(quantityValueController.text !=null && quantityValueController.text.trim() != '') {
                this.totalValueController.text = _calTotal(price, double.parse(quantityValueController.text));
              } else {
                this.totalValueController.text = _calTotal(price, 0.0);
              }
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

  Widget _buildAddButton() {
    return  Container(
      height: 50,
      width: 110,
      margin: EdgeInsets.only(right: 10),
      child: RaisedButton(
        color: Colors.red,
        textColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FaIcon(FontAwesomeIcons.plusCircle,size: 25 , color: Colors.white,),
            Center(child: Text("Add", style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),)),
          ],
        ),
        onPressed: () {
          setState(() {
            Map data = {
              SaleAddItem.productId: this.product.id,
              SaleAddItem.productUrl: this.product.url,
              SaleAddItem.productName: this.product.name,
              SaleAddItem.packageProductName: this.packageProductModel.name,
              SaleAddItem.quantity: quantityValueController.text,
              SaleAddItem.price: this.packageProductModel.price,
              SaleAddItem.total: totalValueController.text
            };
            this.vData.add(data);
            this.cartArrowDownCount = this.vData.length;
            this.next = 0;
            this.product = null;
          });
        },
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

  String _calTotal(double price, double quantity) {
    if(price> 0 && quantity > 0) {
        return FormatNumber.usdFormat2Digit((price * quantity));
    } else {
      return '0';
    }
  }

  Container _showModelSheet() {
    var orientation = MediaQuery.of(context).orientation;
    double height = (MediaQuery.of(context).copyWith().size.height * 0.95);
    setState(() {
      if(orientation != Orientation.portrait){
        height = MediaQuery.of(context).copyWith().size.height * 0.5;
      }
    });

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext builder) {
          return Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.deepPurpleAccent.withOpacity(0.5)
            ),
              child: SaleItems(
                vData: this.vData,
                onChanged: (vChangeData) {
                  setState(() {
                    this.vData = vChangeData;
                    this.cartArrowDownCount = this.vData.length;
                  });
                },
              ),
          );
        });
  }

}
