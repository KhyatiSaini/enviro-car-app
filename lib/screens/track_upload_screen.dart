import 'package:envirocar/providers/user_provider.dart';
import 'package:envirocar/theme/colors_cario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackUploadScreen extends StatefulWidget {
  static String routeName = '/track_upload_screen';

  @override
  _TrackUploadScreenState createState() => _TrackUploadScreenState();
}

class _TrackUploadScreenState extends State<TrackUploadScreen> with SingleTickerProviderStateMixin {
  final List<Widget> _children = [
    LocalTracks(),
    UploadedTracks(),
  ];

  int _selectedIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CarioColors.carioColorPrimary,
        centerTitle: true,
        title: Image.asset('assets/images/envirocar_logo_white.png', width: 100),
      ),
      body: SafeArea(
        child: Container(
          padding: null,
          margin: null,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: CarioColors.carioColorPrimary,
                    width: 2
                  ),
                  color: CarioColors.whiteCario
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Container(
                    height: 30,
                    child: TabBar(
                      tabs: [
                        Tab(text: 'Local'),
                        Tab(text: 'Uploaded'),
                      ],
                      onTap: (index) {
                        _selectedIndex = index;
                        _tabController.index = index;
                      },
                      indicator: BoxDecoration(
                        color: CarioColors.carioColorPrimary,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyle(color: CarioColors.whiteCario),
                      unselectedLabelColor: CarioColors.carioColorPrimary,
                    ),
                  ),
                  initialIndex: _selectedIndex,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: _children,
                  controller: _tabController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocalTracks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              Icons.map,
              size: 150,
              color: Colors.grey.shade400,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'no local tracks'.toUpperCase(),
              style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w600,
                  fontSize: 20
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Text(
              'You have 0 local tracks',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UploadedTracks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              Icons.lock,
              size: 150,
              color: Colors.grey.shade400,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              provider.userLoggedIn ? 'no tracks uploaded'.toUpperCase() : 'not logged in'.toUpperCase(),
              style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w600,
                  fontSize: 20
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
            child: Text(
              provider.userLoggedIn ? 'You have 0 uploaded tracks' : 'To access your remote tracks you have to log in first.',
              style: TextStyle(
                color: Colors.grey.shade400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}