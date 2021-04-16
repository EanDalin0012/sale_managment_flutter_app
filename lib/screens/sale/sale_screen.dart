import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_managment/share/components/show_dialog/show_dialog.dart';
import 'package:sale_managment/share/constant/constantcolor.dart';
import 'package:sale_managment/share/constant/text_style.dart';
import 'package:sale_managment/share/model/sale_transaction.dart';
import 'package:sale_managment/share/utils/number_format.dart';
import 'package:sale_managment/screens/sale/sale_add.dart';
import 'package:sale_managment/share/model/key/transactionKey.dart';

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
  Map mapItems = new Map();
  List<dynamic> vData;

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
    return Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: <Widget>[
            _container(),
            SizedBox(height: 15),
            Row(
              children: this.vData.map((e) {
                print('${e}');
                List<dynamic> mData = e['transactionInfo'];
                return Container(
                  width: size.width,
                  child: Column(
                    children: <Widget>[

                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent
                        ),
                        child: Text(e['transactionDate'])
                      ),
                      // Column(
                      //   children: vData.map((e) =>
                      //     Container(
                      //       width: 20,
                      //       child: Text(e['transactionId'].toString()),
                      //     )
                      //   ).toList(),
                      // ),
                      // _buildBody(mData)
                    ],
                  ),
                );
              }).toList(),
            ),

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
         Text(this.itemLength.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontFamilyDefault),)
        ],
      ),
    );
  }
  Widget _buildBody ( List<dynamic> data) {
    print('_buildBody: ${data[0]}');
    return Expanded(
        child: ListView.separated(
          itemCount: data.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.purple[900].withOpacity(0.5),
          ),
          itemBuilder: (context, index) {
            return _buildListTile(dataItem: data[index]);},
        )
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
    @required Map dataItem
  }) {
    print('dataItem: ${dataItem}');
    return Text(dataItem['transactionId']);
    return ListTile(
      title: Text(dataItem['transactionId'],
        style: TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontFamilyDefault),
      ),
      // leading: _buildLeading(dataItem.productId),
      subtitle: Text(
          FormatNumber.usdFormat2Digit(dataItem['total'].toString()).toString(),
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
                     'a',
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
            // Column(
            //   children: <Widget>[
            //     _offsetPopup(dataItem),
            //   ],
            // ),

          ],
        ),
      ),
    );
  }

  Widget _offsetPopup(Map item) => PopupMenuButton<int>(
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

  Widget _showDialog(Map item) {
    ShowDialog.showDialogYesNo(
        buildContext: context,
        title: Text(item[TransactionKey.transactionDate].transactionDate),
        content: Text('Do you want to delete package of product : '+item[TransactionKey.transactionDate].transactionDate+'?'),
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
      final data = await rootBundle.loadString('assets/json_data/sale_transaction_list.json');
      Map mapItems = jsonDecode(data);

      setState(() {
        this.vData = mapItems['transactionList'];
        this.itemLength = this.vData.length;
        print('mapItems: ${vData[0]}');
        print('mapItems: ${vData.length}');
      });
      return this.vData;
      // var arrObjs = dataItems.map<SaleTransactionModel>((json) {
      //   return SaleTransactionModel.fromJson(json);
      // }).toList();
      //
      // Map dataInfo = new Map();
      // Map transactionDate = new LinkedHashMap();
      // Map transactionInfo = new Map();
      //
      // this.items = arrObjs;
      // var iLength = this.items.length;
      // print('${TransactionKey[0]}');
      // for (var i =0 ; i < iLength; i++) {
      //   print('${this.items[i].transactionDate}');
      //   if(this.items[i].transactionDate == this.items[i+1].transactionDate) {
      //     dataInfo = {
      //       "transactionDate": this.items[i].transactionDate
      //     };
      //   }
      // }
      //
      // setState(() {
      //
      //   this.itemsTmp = this.items;
      // });
      // return this.items;
    // }
  }

}

const Color profile_info_background = Color(0xFF3775FD);
const Color profile_info_categories_background = Color(0xFF939BA9);
const Color furnitureCateDisableColor = Color(0xCD939BA9);

