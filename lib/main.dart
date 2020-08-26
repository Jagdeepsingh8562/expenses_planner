import 'package:expenses_planner/screens/Home.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expensess Planner',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'OpenSans',
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

