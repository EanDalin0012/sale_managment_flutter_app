import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_managment/screens/home/widgets/product_card.dart';
import 'package:sale_managment/screens/widgets/simple_bar_chart.dart';
import 'package:sale_managment/share/model/data/stock_details_data.dart';
import 'package:sale_managment/share/model/stock_details_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static List<StockDetails> stockDetailData = stockDetailsData;
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  static List<charts.Series<OrdinalSales, String>> _createSampleData1() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
      new OrdinalSales('2018', 200),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white60,
      body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildTitledContainer("Sales1",
                    child: Container(
                        height: 200, child: SimpleBarChart(_createSampleData1(), animate: false))),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: stockDetailData.map((e) =>
                    Container(
                        height: 180,
                        width: size.width,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color(0xffd9dbdb).withOpacity(0.4),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5, left: 10),
                                  child: Text(e.stockName.toString(),style: TextStyle(color: Colors.purple[900],fontSize: 18.0,fontWeight: FontWeight.w700, fontFamily: 'roboto, khmer siemreap'),),
                                ),
                              ),
                              SliverToBoxAdapter(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    // margin: EdgeInsets.only(top: 5),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: e.products.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          // access element from list using index
                                          // you can create and return a widget of your choice
                                          return ProductCard(e.products[index], index);
                                        }
                                    ),
                                  )
                              ),
                              SliverToBoxAdapter(
                                  child: SizedBox(height: 20,)
                              )
                            ]
                        )

                    )
                ).toList(),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 75,
              delegate: SliverChildListDelegate([
                Container(color: Colors.blue),
                Container(color: Colors.pink),
                Container(color: Colors.yellow),
              ]),
            ),

          ]
      ),
    );
  }


  AppBar _appBar() {
    return AppBar(
      title: Text('Home'),
      centerTitle: true,
      backgroundColor: Colors.purple[900],
      elevation: 0,
      leading: new Container(),
      actions: <Widget>[
        Stack(
          children: <Widget>[
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NotificationScreen()),
                // );
              },
              child: Container(
                height: 80,
                padding: EdgeInsets.only(
                    top: 5,
                    right: 10,
                    left: 10
                ),
                child: Icon(Icons.notifications),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: EdgeInsets.only(
                  left: 6,
                  top: 1
              ),
              margin: EdgeInsets.only(
                  top: 7,
                  left: 20
              ),
              child: Text('2', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SignInScreen()),
            // );
          },
          child: Container(
            height: 40,
            padding: EdgeInsets.only(
                top: 7,
                right: 5,
                left: 5
            ),
            margin: EdgeInsets.only(
                right: 5
            ),
            child: Icon(Icons.logout),
          ),
        ),
      ],
    );
  }

  Container _buildTitledContainer(String title, {Widget child, double height}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
          ),
          if (child != null) ...[const SizedBox(height: 10.0), child]
        ],
      ),
    );
  }

}
