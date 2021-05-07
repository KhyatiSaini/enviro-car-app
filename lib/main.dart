import 'package:envirocar/providers/bluetooth_status.dart';
import 'package:envirocar/providers/user_provider.dart';
import 'package:envirocar/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BluetoothStatusProvider bluetoothStatusProvider;

  @override
  void initState() {
    bluetoothStatusProvider = new BluetoothStatusProvider();
    bluetoothStatusProvider.determineBluetoothConnectionStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BluetoothStatusProvider()),
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
