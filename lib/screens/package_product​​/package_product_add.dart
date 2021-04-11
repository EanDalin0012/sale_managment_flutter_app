import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sale_managment/screens/widgets/contry_dropdown/country_dropdown.dart';
import 'package:sale_managment/screens/widgets/dropdown_container.dart';
import 'package:sale_managment/screens/widgets/product_dropdown/product_dropdown.dart';
import 'package:sale_managment/share/constant/text_style.dart';
import 'package:sale_managment/share/model/catgory.dart';

class PackageProductAdd extends StatefulWidget {
  @override
  _PackageProductAddState createState() => _PackageProductAddState();
}

class _PackageProductAddState extends State<PackageProductAdd> {

  var borderColorsTextField = Colors.deepPurple;
  var labelStyle = TextStyle(fontSize: 20, color: Colors.deepPurple, fontFamily: fontFamilyDefault);
  var hintStyle = TextStyle(fontFamily: fontFamilyDefault);
  var nameValueController = new TextEditingController();
  var remarkValueController = new TextEditingController();
  var _value = 1;
  var textValue = 'Select Product';
  var colorValue = Colors.deepPurple;
  Map<String, Object> dropdownValue;
  List dropDownListed = [
    {'name': 'Item 1', 'value': 'individual'},
    {'name': 'Item 2', 'value': 'company'},
    {'name': 'Item 3', 'value': 'company'},
    {'name': 'Item 4', 'value': 'individual'},
    {'name': 'Item 5', 'value': 'company'},
    {'name': 'Item 6', 'value': 'company'}
  ];

  Size size;
  @override
  Widget build(BuildContext context) {
     size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: <Widget>[
          _container(),
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
                  child: Center(child: Text('SAVE', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
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
        title: Text('Category', style: TextStyle(fontFamily: 'roboto', fontWeight: FontWeight.w700)),
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
              'Add New Category',
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
                children: <Widget>[
                  CountryDropdown(),
                  ProductDropdown(),
                  _categoryNameField(),
                  _productDropdown(),
                  _productDropdown1(),
                  _categoryRemarkField()
                ])
        )
    );
  }

  Padding _categoryNameField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: nameValueController,
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

  Padding _categoryRemarkField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: remarkValueController,
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


  Container _productDropdown() {
    return Container(
      margin: EdgeInsets.all(10),
      child: DropdownContainer(
        child: DropdownButton(
          isExpanded: true,
          value: dropdownValue,
          underline: new Container(),
          hint: Text(textValue, style: GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.w500, color: colorValue),),
          onChanged: (newValue) {
            print(newValue.toString());
            setState(() {
              this.textValue = newValue['name'];
              this.colorValue = Colors.deepPurple;
            });

          },
          items: dropDownListed.map((map) {
              return DropdownMenuItem(
                child: Text(map['name'], style: GoogleFonts.merriweather(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87)),
                value: map,
              );
            }).toList()
        ),
      ),
    );
  }

  Container _productDropdown1() {
    return Container(
      child: DropdownButton(
        hint: Text('Select Product'),
        dropdownColor: Colors.grey,
        icon: Icon(Icons.arrow_circle_down),
        iconSize: 36,
        isExpanded: true,
        underline: SizedBox(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 22
        ),
        onChanged: (newValue) {

        },
      ),
    );
  }
}
