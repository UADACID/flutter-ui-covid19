import 'package:flutter_covid19/screens/dashboard.dart';
import 'package:flutter_covid19/screens/question.dart';
import 'package:flutter_covid19/screens/splash.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes([
      SailorRoute(
        name: "/splash",
        builder: (context, args, params) => Splash(),
      ),
      SailorRoute(
        name: "/dashboard",
        builder: (context, args, params) => Dashboard(),
      ),
      SailorRoute(
        name: "/question",
        builder: (context, args, params) => Question(),
      )
    ]);
  }
}
