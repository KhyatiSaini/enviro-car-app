import 'package:envirocar/providers/user_provider.dart';
import 'package:envirocar/theme/colors_cario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OthersScreen extends StatelessWidget {
  static String routeName = '/others_screen';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CarioColors.carioColorPrimary,
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
                if (provider.userLoggedIn)
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Are you sure?'),
                            content: Text('Do you want to logout?'),
                            actions: [
                              TextButton(
                                child: Text(
                                  'no'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black54
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'yes'.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black54
                                  ),
                                ),
                                onPressed: () {
                                  provider.logout(context);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                    );
                  },
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18
                    ),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 30,
                  ),
                  dense: true,
                ),
                if (provider.userLoggedIn)
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
                    color: CarioColors.carioWarningRed,
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