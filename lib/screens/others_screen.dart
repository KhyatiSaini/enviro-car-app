import 'package:flutter/material.dart';

class OthersScreen extends StatelessWidget {
  static String routeName = '/others_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade800,
        centerTitle: true,
        title: Image.asset('assets/images/envirocar_logo_white.png', width: 100),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 5),
                ListTile(
                  title: Text(
                    'Log Book',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18
                    ),
                  ),
                  leading: Icon(
                    Icons.my_library_books,
                    color: Colors.black,
                    size: 30,
                  ),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Settings',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18
                    ),
                  ),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 30,
                  ),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Help',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18
                    ),
                  ),
                  leading: Icon(
                    Icons.help_outline_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Report Issue',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18
                    ),
                  ),
                  leading: Icon(
                    Icons.bug_report_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Rate Us',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18
                    ),
                  ),
                  leading: Icon(
                    Icons.star,
                    color: Colors.black,
                    size: 30,
                  ),
                  dense: true,
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Close enviroCar',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18
                    ),
                  ),
                  leading: Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                    size: 30,
                  ),
                  dense: true,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}