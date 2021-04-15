import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_managment/screens/widgets/product_dropdown/product_page.dart';
import 'package:sale_managment/share/components/show_dialog/show_dialog.dart';
import 'package:sale_managment/share/constant/constantcolor.dart';
import 'package:sale_managment/share/constant/icon/custome_icon.dart';
import 'package:sale_managment/share/constant/text_style.dart';
import 'package:sale_managment/share/model/product.dart';
import 'package:sale_managment/share/model/sale_transaction.dart';
import 'package:sale_managment/share/utils/number_format.dart';
import 'package:sale_managment/screens/sale/sale_add.dart';

class SaleScreen extends StatefulWidget {
  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  Size size ;
  var controller = TextEditingController();
  var isItemChanged = false;
  var isFilterByProduct = false;
  var isNative = false;
  List<SaleTransactionModel> items = [];
  List<SaleTransactionModel> itemsTmp = [];

  // List<ProductModel> productItems = [];
  // ProductModel product;

  int itemLength = 0;

  var menuStyle = TextStyle( color: Colors.purple[900], fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);


  @override
  void initState() {
    super.initState();
    this._fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    this.itemLength = this.items.length;
    return Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: <Widget>[
            _container(),
            _buildBody()
          ],
        ),
        floatingActionButton: _floatingActionButton()
    );
  }

  Container _container() {
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      width: size.width,
      padding: EdgeInsets.only(
          left: 20,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Sale of Product List',
            style: containStyle,
          ),
         Text(itemLength.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault),)
        ],
      ),
    );
  }
  Widget _buildBody () {
    return Expanded(
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.purple[900].withOpacity(0.5),
          ),
          itemBuilder: (context, index) {
            return _buildListTile(
                dataItem: items[index]
            );},
        )
    );
  }


  Widget build1(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ProfileCategories(),
        ])
    );
  }
  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.purple[900],
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SaleAddScreen()),
        );
      },
      tooltip: 'Increment',
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple[900],
      title: Text('Sale of Products'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            this.isNative = !isNative;
            this.isItemChanged = false;
            this.isFilterByProduct = false;
          }),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: size.width - 60,
              child: _buildSearchWidget(
                text: controller.text,
                // onChanged: (text) => setState(() => this.text = text),
                hintText: 'Search by name', onTap: () {  },
              ),
            ),
            _buildFilterByProduct()
          ],
        ),
      ): null,
    );
  }

  Widget _buildSearchWidget({
    @required String text,
    @required String hintText,
    @required VoidCallback onTap,
    Widget leading,
  }) {
    final styleActive = TextStyle(color: Colors.black, fontSize: 15);
    final styleHint = TextStyle(color: Colors.black54);
    final style = text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 40,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: InkWell(
              onTap: () {
                print('data search');
              },
              child: Icon(Icons.search, color: style.color)),
          suffixIcon: text.isNotEmpty ? GestureDetector(
            child: Icon(Icons.close, color: style.color),
            onTap: () {
              controller.clear();
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ) : null,
          hintText: hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: (value) {
          this.isItemChanged = true;
          if(value != null || value.trim() != '') {
            this.isItemChanged = true;
            if(value != null || value.trim() != '') {
              setState(() {
                // items = onItemChanged(value);
              });
            }
          }
        },
      ),
    );
  }

  Widget _buildFilterByProduct() {
    return Container(
      height: 40,
      // padding: EdgeInsets.only(
      //   right: 3
      // ),
      child: IconButton(
        icon: FaIcon(FontAwesomeIcons.filter,size: 25 , color: Colors.white,),
        tooltip: 'Increase volume by 10',
        onPressed: () async {
        //   final product = await Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => ProductPage(
        //       productModel: this.product,
        //     )),
        //   );
        //
        //   if (product == null) return;
        //   this.isItemChanged = false;
        //   this.isFilterByProduct = true;
        //   setState(() {
        //     this.product = product;
        //   });
        },
      ),
    );
  }

  Widget _buildListTile( {
    @required SaleTransactionModel dataItem
  }) {
    return ListTile(
      title: Text( dataItem.transactionData,
        style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      // leading: _buildLeading(dataItem.productId),
      subtitle: Text(
          FormatNumber.usdFormat2Digit(dataItem.total.toString()) +' \$,'+dataItem.remark.toString(),
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault, color: primaryColor),
      ),
      trailing: Container(
        width: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      dataItem.remark.toString(),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                _offsetPopup(dataItem),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _offsetPopup(SaleTransactionModel item) => PopupMenuButton<int>(
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
        _showDialog(item);
      }
    },
  );

  Widget _showDialog(SaleTransactionModel item) {
    ShowDialog.showDialogYesNo(
        buildContext: context,
        title: Text(item.transactionData),
        content: Text('Do you want to delete package of product : '+item.transactionData+'?'),
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

  Widget _buildLeading(int productId) {
    var url = 'https://icons-for-free.com/iconfiles/png/512/part+1+p-1320568343314317876.png'; //_searchProductById(productId);
    if(url == null) {
      url = 'https://icons-for-free.com/iconfiles/png/512/part+1+p-1320568343314317876.png';
    }
    return Container(
      width: 50,
      height: 50,
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

  _fetchItems() async {
    // if(isItemChanged == true) {
    //   if(controller.text != null) {
    //     setState(() {
    //       isItemChanged = true;
    //       items = onItemChanged(controller.text);
    //     });
    //   }
    //   return items;
    // } else if(isFilterByProduct == true) {
    //   this.items = this._doFilterByProduct(this.product);
    //   return items;
    // } else if(this.isNative == false && this.itemsTmp.length > 0) {
    //   this.items = itemsTmp;
    //   return this.items;
    // } else {
      final data = await rootBundle.loadString(
          'assets/json_data/sale_transaction_list.json');
      Map valueMap = jsonDecode(data);
      var dataItems = valueMap['transactionList'];
      var arrObjs = dataItems.map<SaleTransactionModel>((json) {
        return SaleTransactionModel.fromJson(json);
      }).toList();
      // this.items = arrObjs;
      // this.itemsTmp = this.items;
      // _fetchProductItems();
      setState(() {
        this.items = arrObjs;
        this.itemsTmp = this.items;
      });
      return this.items;
    // }
    return null;
  }

}

















// class Catg {
//   String name;
//   IconData icon;
//   int number;
//   Catg({this.icon, this.name, this.number});
// }

//
// List<Catg> listProfileCategories = [
//   Catg(name: 'Wallet', icon: CustomIcon.account_balance_wallet, number: 0),
//   Catg(name: 'Delivery', icon: CustomIcon.truck, number: 0),
//   Catg(name: 'Message', icon: CustomIcon.chat, number: 2),
//   Catg(name: 'Service', icon: CustomIcon.money, number: 0),
// ];
//
// class FurnitureCategory extends StatelessWidget {
//   final FurnitureCatg item;
//   FurnitureCategory({@required this.item});
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 25.0),
//         child: Transform.rotate(
//           angle: pi / 4,
//           child: Container(
//             padding: EdgeInsets.all(10.0),
//             decoration: BoxDecoration(
//               boxShadow: [
//                 if (item.elivation)
//                   BoxShadow(
//                     color: Color(0xFFD1DCFF),
//                     blurRadius: 5.0, // has the effect of softening the shadow
//                     spreadRadius:
//                     -1.0, // has the effect of extending the shadow
//                     offset: Offset(10.0, 10.0),
//                   )
//               ],
//               color: item.elivation ? profile_info_background : profile_info_categories_background,
//               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//             ),
//             child: Transform.rotate(
//               angle: -pi / 4,
//               child: Icon(
//                 item.icon,
//                 size: 30.0,
//                 color:
//                 item.elivation ? Colors.white : furnitureCateDisableColor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class FurnitureCatg {
//   IconData icon;
//   bool elivation;
//   FurnitureCatg({this.icon, this.elivation});
// }

//COLORS
const Color profile_info_background = Color(0xFF3775FD);
const Color profile_info_categories_background = Color(0xFF939BA9);
const Color furnitureCateDisableColor = Color(0xCD939BA9);
//
// // da
// class ProfileCategories extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           for (Catg catg in listProfileCategories)
//             Category(
//               catg: catg,
//             )
//         ],
//       ),
//     );
//   }
// }


//
// class Category extends StatelessWidget {
//   final Catg catg;
//   Category({this.catg});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Stack(
//           overflow: Overflow.visible,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 if (catg.name == listProfileCategories[0].name)
//                   Navigator.pushNamed(context, '/furniture');
//               },
//               child: Container(
//                 padding: EdgeInsets.all(10.0),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: profile_info_categories_background,
//                 ),
//                 child: Icon(
//                   catg.icon,
//                   // size: 20.0,
//                 ),
//               ),
//             ),
//             catg.number > 0
//                 ? Positioned(
//               right: -5.0,
//               child: Container(
//                 padding: EdgeInsets.all(5.0),
//                 decoration: BoxDecoration(
//                   color: profile_info_background,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   catg.number.toString(),
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 10.0,
//                   ),
//                 ),
//               ),
//             )
//                 : SizedBox(),
//           ],
//         ),
//         SizedBox(
//           height: 10.0,
//         ),
//         Text(
//           catg.name,
//           style: TextStyle(
//             fontSize: 13.0,
//           ),
//         )
//       ],
//     );
//   }
//
// }
