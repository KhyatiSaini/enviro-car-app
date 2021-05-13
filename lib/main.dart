import 'package:envirocar/providers/bluetooth_status_provider.dart';
import 'package:envirocar/providers/gps_status_provider.dart';
import 'package:envirocar/providers/user_provider.dart';
import 'package:envirocar/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BluetoothStatusProvider()),
        ChangeNotifierProvider(create: (_) => GpsStatusProvider()),
      ],
      child: MaterialApp(
        title: 'Enviro Car',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            unselectedWidgetColor: Colors.grey.shade400
        ),
        home: HomeScreen(),
        routes: routes,
      ),
    );
  }
}
