import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sale_managment/screens/home/home_container_screen.dart';
import 'package:sale_managment/screens/notification/notification_screen.dart';
import 'package:sale_managment/screens/sale/sale_screen.dart';
import 'package:sale_managment/screens/sign_in/sign_in_screen.dart';
import 'package:sale_managment/screens/widgets/simple_bar_chart.dart';
import 'package:sale_managment/share/constant/constantcolor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _titleBar = 'Home';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab = !await _navigatorKeys[_selectedIndex].currentState.maybePop();
          print(
              'isFirstRouteInCurrentTab: ' + isFirstRouteInCurrentTab.toString());
          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          appBar: appBar(),
          backgroundColor: Theme.of(context).buttonColor,
          bottomNavigationBar: _bottomNavigationBar(),
          body: _widgetOptions.elementAt(_selectedIndex),
        )
    );
  }


  AppBar appBar() {
    return AppBar(
      title: Text(_titleBar),
      centerTitle: true,
      backgroundColor: Colors.purple[900],
      elevation: 0,
      leading: new Container(),
      actions: <Widget>[
        Stack(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
            );
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
  BottomNavigationBar _bottomNavigationBar() {
    double activeIconSize = 36;
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Feather.home,
            color: kGoodLightGray,
          ),
          title: Text('HOME'),
          activeIcon: Icon(
            Feather.home,
            color: kGoodPurple,
            size: 30,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Feather.plus_circle,
            color: kGoodLightGray,
          ),
          title: Text('CALENDAR'),
          activeIcon: Icon(
            Feather.plus_circle,
            color: kGoodPurple,
            size: activeIconSize,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Feather.align_left,
            color: kGoodLightGray,
          ),
          title: Text('PROFILE'),
          activeIcon: Icon(
            Feather.align_left,
            color: kGoodPurple,
            size: activeIconSize,
          ),
        ),
      ],
      onTap: (index) {
        setState(() {
          if(index == 0) {
            _titleBar = 'Home';
          } else if (index == 1) {
            _titleBar = 'Sale';
          }
          if(index >= 2) {
            // _showModelSheet();
          } else {
            _selectedIndex = index;
          }
        });
        // _selectedIndex = index;
      },
    );
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeContainerScreen(),
    SaleScreen(),
  ];

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];
}
