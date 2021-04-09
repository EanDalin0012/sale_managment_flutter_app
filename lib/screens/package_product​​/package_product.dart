import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_managment/screens/package_product%E2%80%8B%E2%80%8B/package_product_add.dart';
import 'package:sale_managment/share/components/show_dialog/show_dialog.dart';
import 'package:sale_managment/share/constant/text_style.dart';
import 'package:sale_managment/share/model/catgory.dart';

class PackageProductScreen extends StatefulWidget {
  @override
  _PackageProductScreenState createState() => _PackageProductScreenState();
}

class _PackageProductScreenState extends State<PackageProductScreen> {

  bool isSearch = false;
  TextEditingController _controller;
  // List<CategoryModel> categories = categoriesData;
  var menuStyle = TextStyle( color: Colors.purple[900], fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Column(
          children: <Widget>[
            isSearch ? _containerSearch() : _container(),
            // _mainTransactionBody()
          ],
        ),
        floatingActionButton: _floatingActionButton()
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Representative', style: appBarStyle,),
      backgroundColor: Colors.purple[900],
    );
  }

  Container _containerSearch() {
    return Container(
      height: 60,
      // margin: const EdgeInsets.symmetric(
      //   vertical: 8.0,
      //   horizontal: 16.0,
      // ),
      decoration: BoxDecoration(
          color: Colors.grey.shade200
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: _controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: "Search here"),
              onEditingComplete: _save,
            ),
          ),
        ],
      ),
    );
  }

  _save() async {
    // if (_controller.text.isEmpty) return;
    // FocusScope.of(context).requestFocus(FocusNode());
    // setState(() {
    //   messages.insert(0, Message(rand.nextInt(2), _controller.text));
    //   _controller.clear();
    // });
  }

  Widget _offsetPopup(CategoryModel categoryModel) => PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
          value: 2,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.edit,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                "Edit",
                style: menuStyle,
              ),
            ],
          )
      ),
      PopupMenuItem(
          value: 3,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.trash,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                "Delete",
                style: menuStyle,
              ),
            ],
          )
      ),
    ],
    icon: FaIcon(FontAwesomeIcons.ellipsisV,size: 20,color: Colors.black),
    offset: Offset(0, 45),
    onSelected: (value) {
      if(value == 1) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => VendorViewScreen(vendorModel)),
        // );
      } else if(value == 2) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => EditCategoryScreen(categoryModel)),
        // );
      } else if (value == 3) {
        _showDialog(categoryModel);
      }
    },
  );

  Widget _showDialog(CategoryModel _vendorModel) {
    ShowDialog.showDialogYesNo(
        buildContext: context,
        title: Text(_vendorModel.name),
        content: Text('Do you want to delete category : '+_vendorModel.name+'?'),
        btnRight: 'Yes',
        onPressedBntRight: () {
          print('onPressedBntRight');
        },
        btnLeft: 'No',
        onPressedBntLeft: () {
          print('onPressedBntLeft');
        }
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.purple[900],
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PackageProductAdd()),
        );
      },
      tooltip: 'Increment',
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }

  Container _container() {
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      padding: EdgeInsets.only(
          left: 20,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Representative Product List',
            style: containStyle,
          ),
          InkWell(
            onTap: () {
              print(isSearch);

              setState(() {
                this.isSearch = true;
              });
            },
            child: FaIcon(FontAwesomeIcons.search,size: 15 , color: Colors.blueGrey,),
          ),
        ],
      ),
    );
  }
}
