import 'package:flutter/material.dart';
import 'package:flutter_covid19/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailor/sailor.dart';
import 'package:simple_animations/simple_animations.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.redirect();
  }

  redirect() {
    Future.delayed(Duration(seconds: 3), () {
      Routes.sailor.navigate(
        '/dashboard',
        navigationType: NavigationType.pushAndRemoveUntil,
        removeUntilPredicate: (a) => false,
        transitions: [
          SailorTransition.fade_in,
        ],
        transitionDuration: Duration(milliseconds: 1500),
        transitionCurve: Curves.bounceOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Hero(
          tag: 'background',
          child: Container(
            height: size.height,
            width: size.width,
            color: Theme.of(context).cardColor,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // backgroundColor: Theme.of(context).cardColor,
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildIcon(),
                  SizedBox(
                    height: ScreenUtil().setWidth(30),
                  ),
                  _buildTitle()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Text _buildTitle() {
    return Text(
      'COVID-19',
      style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(24)),
    );
  }

  ControlledAnimation<double> _buildIcon() {
    return ControlledAnimation(
        playback: Playback.MIRROR,
        duration: Duration(milliseconds: 1000),
        tween: Tween(begin: 1.0, end: 0.9),
        builder: (context, scale) {
          return Transform.scale(
            scale: scale,
            child: SvgPicture.asset('assets/images/virus.svg',
                height: ScreenUtil().setWidth(200),
                semanticsLabel: 'Acme Logo'),
          );
        });
  }
}
