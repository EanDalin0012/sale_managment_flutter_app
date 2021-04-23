import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_managment/share/constant/text_style.dart';
import 'package:sale_managment/share/model/key/transactionKey.dart';

class SaleAddConfirm extends StatefulWidget {
  final List<dynamic> vData;
  SaleAddConfirm({
    @required this.vData
});
  @override
  _SaleAddConfirmState createState() => _SaleAddConfirmState();
}

class _SaleAddConfirmState extends State<SaleAddConfirm> {
  Size size;
  var styleInput = TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault);
  var remarkValueController = new TextEditingController();
  var nameValueController = new TextEditingController();
  var i = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    this.i = 0;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              _container(),
              _remarkField(),
              _remarkField(),
              Divider(
                color: Colors.purple[900].withOpacity(0.5),
              ),
              _body(),
              Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      width: size.width,
                      height: 45,
                      color: Colors.red,
                      child: Center(child: Text('Confirm', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: Text('Conform', style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700)),
        backgroundColor: Colors.purple[900],
    );
  }

  Widget _buildConfirmButton () {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            print('click');
          },
          child: Container(
            width: size.width,
            height: 45,
            color: Colors.deepPurple,
            child: Center(child: Text('Next', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
          ),
        ),
      ],
    );
  }

  Widget _container() {
    return  Container(
        color: Color(0xFF939BA9).withOpacity(0.5),
        height: 40,
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
                'Sale Conform',
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500, fontFamily: fontFamilyDefault)
            ),
          ],
        ),
    );
  }

  Widget buildListView() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
    child: Column(

      )
    );
  }

  Widget _buildDataTable() {
    return DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text('No'),
          ),
          DataColumn(
            label: Text('Product'),
          ),
          DataColumn(
            label: Text('Package'),
          ),
          DataColumn(
            label: Text('Quantity'),
          ),
          DataColumn(
            label: Text('Total'),
          ),
          DataColumn(
            label: Text('Action'),
          ),
        ],
        rows: widget.vData.map((e) {
          i += 1;
          return DataRow(
              cells: <DataCell>[
                DataCell(Text(i.toString())),
                DataCell(
                    Row(
                        children: <Widget>[
                          _buildLeading(e[SaleAddItem.productUrl].toString()),
                          SizedBox(width: 10),
                          Text(e[SaleAddItem.productName].toString())
                        ]
                    )
                ),
                DataCell(Text(e[SaleAddItem.packageProductName].toString())),
                DataCell(Text(e[SaleAddItem.quantity].toString())),
                DataCell(Text(e[SaleAddItem.total].toString() + ' \$')),
                DataCell(_buildRemoveButton(e))
              ]
          );
        }

        ).toList()
    );
  }

  Widget _buildLeading(String url) {
    return Container(
      width: 35,
      height: 35,
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

  Widget _buildRemoveButton(Map<dynamic, dynamic> item) {
    return  Container(
      height: 35,
      width: 120,
      child: RaisedButton.icon(
          color: Colors.red,
          elevation: 4.0,
          onPressed: () {
            setState(() {
              widget.vData.remove(item);
              print('remove: ${widget.vData}');
            });
          },
          icon: FaIcon(FontAwesomeIcons.minusCircle,size: 20 , color: Colors.white,),
          label: Text('Remove',style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white))
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

  Expanded _body() {
    return Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: size.height - 100,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: <Widget>[
                          _buildDataTable(),
                        ],
                      ),
                    ),
                  ),
                ])
        )
    );
  }

}
