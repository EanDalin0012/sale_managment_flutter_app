import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeContainerScreen extends StatefulWidget {
  @override
  _HomeContainerScreenState createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  List<charts.Series> seriesList;

  static List<charts.Series<Sales, String>> _createRandomData() {
    final random = Random();

    final desktopSalesData = [
      Sales('2015', random.nextInt(100)),
      Sales('2016', random.nextInt(100)),
      Sales('2017', random.nextInt(100)),
      Sales('2018', random.nextInt(100)),
      Sales('2019', random.nextInt(100)),
    ];

    final tabletSalesData = [
      Sales('2015', random.nextInt(100)),
      Sales('2016', random.nextInt(100)),
      Sales('2017', random.nextInt(100)),
      Sales('2018', random.nextInt(100)),
      Sales('2019', random.nextInt(100)),
    ];

    final mobileSalesData = [
      Sales('2015', random.nextInt(100)),
      Sales('2016', random.nextInt(100)),
      Sales('2017', random.nextInt(100)),
      Sales('2018', random.nextInt(100)),
      Sales('2019', random.nextInt(100)),
    ];

    return [
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: desktopSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
      ),
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: tabletSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.green.shadeDefault;
        },
      ),
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: mobileSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.teal.shadeDefault;
        },
      )
    ];
  }
  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Row(
          children: <Widget>[
            _barChart(size)
          ],
        )
    );
  }
  Container _barChart(Size size) {
    return Container(
      width: size.width,
      height: 300,
      color: Colors.black12,
      padding: EdgeInsets.all(20.0),
      child: barChart(),
    );
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: false,
      vertical: true,
    );
  }
  _buildBody(BuildContext context) {
    return SingleChildScrollView(
        child: Row(
          children: <Widget>[
            _buildActivities(context)
          ],
        )

    );
  }

  SliverPadding _buildActivities(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
        child: _buildTitledContainer(
          "Activities",
          height: 280,
          child: Expanded(
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: activities
                  .map((activity) =>
                  Column(
                    children: <Widget>[
                      CircleAvatar(radius: 20, backgroundColor: Theme
                          .of(context)
                          .buttonColor,
                        child: activity.icon != null ? Icon(
                            activity.icon, size: 18.0) : null,
                      ),
                      const SizedBox(height: 8.0),
                      Text(activity.title, textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                    ],
                  ),
              ).toList(),
            ),
          ),
        ),
      ),
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

final List<Activity> activities = [
  Activity(title: "Results", icon: FontAwesomeIcons.listOl),
  Activity(title: "Messages", icon: FontAwesomeIcons.sms),
  Activity(title: "Appointments", icon: FontAwesomeIcons.calendarDay),
  Activity(title: "Video Consultation", icon: FontAwesomeIcons.video),
  Activity(title: "Summary", icon: FontAwesomeIcons.fileAlt),
  Activity(title: "Billing", icon: FontAwesomeIcons.dollarSign),
];
class Activity {
  final String title;
  final IconData icon;
  Activity({this.title, this.icon});
}

class Sales {
  final String year;
  final int sales;

  Sales(this.year, this.sales);
}
