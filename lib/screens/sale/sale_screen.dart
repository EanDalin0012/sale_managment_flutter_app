import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_managment/share/constant/constantcolor.dart';
import 'package:sale_managment/share/constant/text_style.dart';
import 'package:sale_managment/share/model/sale_transaction.dart';
import 'package:sale_managment/share/utils/number_format.dart';
import 'package:sale_managment/screens/sale/sale_add.dart';
import 'package:intl/intl.dart';

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
  List<dynamic> vData = [];
  int itemLength = 0;
  var menuStyle = TextStyle( color: Colors.purple[900], fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
 var color = Color.fromRGBO(58, 66, 86, 1.0);

  @override
  void initState() {
    super.initState();
    this.todayDate();
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
            SizedBox(height: 10,),
            if(this.vData.length > 0) Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: this.vData.map((e) {
                  List<dynamic> mData = e['transactionInfo'];
                  var mDataLength = mData.length;
                  var i = 0;
                  return Container(
                    width: size.width,
                    // margin: EdgeInsets.only(
                    //   top: 10,
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Color(0xCD939BA9).withOpacity(0.5),
                          width: size.width,
                          padding: EdgeInsets.all(10),
                          child: Text(
                              e['transactionDate'],
                            style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                        ),
                        Column(
                          children: mData.map((item) {
                            i += 1;
                            return Container(
                              decoration: mDataLength != i ? BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Color(0xCD939BA9).withOpacity(0.2), width: 1.5),
                                  )
                              ) : null,
                              child: ListTile(
                                leading: _buildLeading(),
                                title: Text(
                                  item['transactionId'],
                                  style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontFamily: fontFamilyDefault),
                                ),
                                trailing: Container(
                                  width: 110,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        FormatNumber.usdFormat2Digit(item['total'].toString()).toString() + ' \$',
                                        style: TextStyle(fontFamily: fontFamilyDefault, fontSize: 20, fontWeight: FontWeight.w700, color: color),
                                      ),
                                      SizedBox(width: 10,),
                                      FaIcon(FontAwesomeIcons.chevronRight,size: 20 , color: Colors.black54.withOpacity(0.5))
                                    ]
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )

          ],
        ),
        floatingActionButton: _floatingActionButton()
    );
  }

  Widget _container() {
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      width: size.width,
      height: 40,
      padding: EdgeInsets.only(
          left: 20,
          right: 20
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
        icon: FaIcon(FontAwesomeIcons.filter,size: 25 , color: Colors.white),
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
  }

  Widget _buildLeading() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.7), width: 2),
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.transparent,
        child: FaIcon(FontAwesomeIcons.receipt,size: 20 , color: Colors.deepPurple),
      ),
    );
  }

  todayDate() {
    // var myDate = '2020-01-02';
    // var changeFormat = myDate.replace(/(\d{2})-(\d{2})-(\d{4})/, "$2/$1/$3")
    print(DateTime.parse('2020-01-02'));
    var d = DateTime.parse('2020-01-02');
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MMM-yyyy');
    // String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(d);
    // print(formattedTime);
    print(formattedDate);
  }

}

const Color profile_info_background = Color(0xFF3775FD);
const Color profile_info_categories_background = Color(0xFF939BA9);
const Color furnitureCateDisableColor = Color(0xCD939BA9);
