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
  Color _iconColor = Colors.purple[900];
  var i = 0;

  @override
  Widget build(BuildContext context) {
    print('${widget.vData}');
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          // _container(),
          Container(
            color: Colors.white,
            height: size.height - 170,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildDataTable(),
                ),
              ),
            ),
          ),
          _buildConfirmButton()
        ],
      ),
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
            color: Colors.red,
            child: Center(child: Text('Next', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
          ),
        ),
      ],
    );
  }

  Container _container() {
    return Container(
      color: Color(0xFF939BA9),
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
              style: containStyle
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

}
