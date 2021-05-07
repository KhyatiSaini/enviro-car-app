import 'package:envirocar/screens/dashboard_screen.dart';
import 'package:envirocar/screens/others_screen.dart';
import 'package:envirocar/screens/track_upload_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  final List<Widget> _children = [
    DashboardScreen(),
    TrackUploadScreen(),
    OthersScreen(),
  ];
  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: _children.length, vsync: this);
    _tabController.addListener(handleTabSelection);
    super.initState();
  }

  void handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.speed),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_road_outlined),
            label: 'Tracks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Others',
          ),
        ],
        onTap: (index) {
          setState(() {
            _tabController.index = index;
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.lightBlue.shade800,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(color: Colors.lightBlue.shade800),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedLabelStyle: TextStyle(color: Colors.lightBlue.shade800),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedFontSize: 12,
        selectedFontSize: 12,
      ),
      body: TabBarView(
        children: _children,
        controller: _tabController,
      ),
    );
  }
}