import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeContainerScreen extends StatefulWidget {
  @override
  _HomeContainerScreenState createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .buttonColor,
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        // _buildStats(),
        // SliverToBoxAdapter(
        //   child: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: _buildTitledContainer("Sales",
        //         child: Container(height: 200, child: DonutPieChart.withSampleData())),
        //   ),
        // ),
        _buildActivities(context),
      ],
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
