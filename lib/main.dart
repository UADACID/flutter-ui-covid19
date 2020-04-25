import 'package:flutter/material.dart';
import 'package:flutter_covid19/routes.dart';
import 'package:flutter_covid19/screens/dashboard.dart';
import 'package:flutter_covid19/screens/splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  Routes.createRoutes();
  runApp(App());
}

class App extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.openSansTextTheme(),
        cardColor: Color(0xff232B45)
      ),
      home: Splash(),
      navigatorKey: Routes.sailor.navigatorKey,
      onGenerateRoute: Routes.sailor.generator(),
      builder: (_, child) {
        ScreenUtil.init(_, width: 446, height: 964);
        return Scaffold(
          key: _scaffoldKey,
          body: child,
        );
      },
    );
  }
}
