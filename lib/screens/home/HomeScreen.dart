import 'package:flutter/material.dart';
import 'package:sale_managment/screens/home/widgets/product_card.dart';
import 'package:sale_managment/share/model/data/stock_details_data.dart';
import 'package:sale_managment/share/model/stock_details_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<StockDetails> stockDetailData = stockDetailsData;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
         child: Container(
          alignment: Alignment.center,
          color: Theme.of(context).buttonColor,
          child: Column(
              children: <Widget> [
                Column(
                  children: stockDetailData.map((e) =>
                    Container(
                      height: 160,
                      width: size.width,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, left: 10),
                                child: Text(e.stockName.toString(),),
                              ),
                            ),
                            SliverToBoxAdapter(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  margin: EdgeInsets.only(top: 16),
                                  child: PageView(
                                    controller: PageController(viewportFraction: 0.8,initialPage: 2),
                                    children: e.products.map((item) =>
                                      ProductCard(item)
                                    ).toList(),
                                  ),
                                )
                            )
                          ]
                      )

                    )
                  ).toList(),
                ),

                Container(
                  height: 600,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48),
                      )),
                  child: Text('Data'),
                ),
              ]
          )
        ),
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

}
