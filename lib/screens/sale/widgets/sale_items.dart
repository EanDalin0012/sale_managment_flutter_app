import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_managment/share/constant/text_style.dart';

class SaleItems extends StatelessWidget {
  Color _iconColor = Colors.purple[900];

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              _widgetStack(context),
              drawerHandler(),
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height - 155,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                              children: <Widget>[
                                _buildDataTable(),
                              ]
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 39,
                color: Colors.red,
              )
            ],
          ),
        );
  }

  drawerHandler() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 4,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffd9dbdb)
      ),
    );
  }

  Widget _buildConfirm(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            // margin: EdgeInsets.only(
            //   left: 5,
            //   right: 5
            // ),
            child: Center(child: Text('Confirm', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'roboto', fontSize: 18))),
          ),
        ),
      ],
    );
  }
  Widget _widgetStack(BuildContext context) {
    return Stack(
        children: [
          Container(
            width: double.infinity,
            height: 35.0,
            child: Center(
                child: Text("Items",
                    style: TextStyle(fontFamily: fontFamilyDefault, fontWeight: FontWeight.w700, fontSize: 20, color: _iconColor)
                ) // Your desired title
            ),
          ),
          Positioned(
              left: 0.0,
              top: 0.0,
              child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.arrowLeft,size: 20 , color: _iconColor,), // Your desired icon
                  onPressed: (){
                    Navigator.of(context).pop();
                  }
              )
          )
        ]
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
      ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
              DataCell(Text('Data')),
            ],
          ),

        ]
    );
  }
}
