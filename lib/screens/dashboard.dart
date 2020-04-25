import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailor/sailor.dart';
import 'package:simple_animations/simple_animations.dart';

import '../routes.dart';

class Dashboard extends StatelessWidget {
  Widget _buildAnimation(
      Widget widget, Duration duration, Duration delay, Offset offset) {
    return ControlledAnimation(
        delay: delay,
        duration: duration,
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, opacityValue) {
          return Opacity(
              opacity: opacityValue,
              child: ControlledAnimation(
                  delay: delay,
                  duration: duration,
                  tween: Tween(begin: offset, end: Offset.zero),
                  builder: (context, offsetValue) {
                    return Transform.translate(
                        offset: offsetValue, child: widget);
                  }));
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAnimation(_buildHeader(), Duration(milliseconds: 300),
                Duration(milliseconds: 800), Offset(0, -50)),
            SizedBox(
              height: ScreenUtil().setWidth(50),
            ),
            _buildBanner(size, context),
            SizedBox(
              height: ScreenUtil().setWidth(40),
            ),
            // _buildLatesUpdateInfo(),
            _buildAnimation(
                _buildLatesUpdateInfo(),
                Duration(milliseconds: 400),
                Duration(milliseconds: 1000),
                Offset(0, 50)),
            SizedBox(
              height: ScreenUtil().setWidth(30),
            ),
            // _buildChart(context)
            _buildAnimation(_buildChart(context), Duration(milliseconds: 700),
                Duration(milliseconds: 1500), Offset(0, 0)),
          ],
        )),
      ),
    ));
  }

  Column _buildChart(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Active Case',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(23),
                      fontWeight: FontWeight.bold)),
              Text('18 - 22 Mar',
                  style: TextStyle(
                      color: Color(0xff0577F0),
                      fontSize: ScreenUtil().setSp(13),
                      fontWeight: FontWeight.bold)),
            ],
          )),
      SizedBox(
        height: ScreenUtil().setWidth(10),
      ),
      // Container(child: Text('Graphic')),
      // sample3(context)
      _buildTab(context)
    ]);
  }

  Widget _buildTab(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(191),
      child: DefaultTabController(
        length: 3,
        child: Column(children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffEDEEF7), width: 2))),
            child: Transform.translate(
              offset: Offset(-16, 0),
              child: TabBar(
                isScrollable: true,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                labelColor: Colors.black,
                unselectedLabelColor: Color(0xffB1BDD0),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                indicatorColor: Color(0xff323A52),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0),
                    insets: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(18))),
                tabs: <Widget>[
                  Tab(
                    text: 'Daily',
                  ),
                  Tab(
                    text: 'Weekly',
                  ),
                  Tab(
                    text: 'Monthly',
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            child: TabBarView(
              children: [sample3(context), sample3(context), sample3(context)],
            ),
          ),
        ]),
        // child: Scaffold(
        //   appBar: AppBar(
        //     bottom: PreferredSize(
        //       preferredSize: Size(100, 50),
        //                   child: TabBar(
        //         tabs: [
        //           Tab(icon: Icon(Icons.directions_car)),
        //           Tab(icon: Icon(Icons.directions_transit)),
        //           Tab(icon: Icon(Icons.directions_bike)),
        //         ],
        //       ),
        //     ),
        //   ),
        //   body: TabBarView(
        //     children: [
        //       sample3(context),
        //       sample3(context),
        //       sample3(context)
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget sample3(BuildContext context) {
    final fromDate = DateTime(2020, 04, 01);
    final toDate = DateTime.now();

    final date1 = DateTime.now().subtract(Duration(days: 2));
    final date2 = DateTime.now().subtract(Duration(days: 3));

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
        // color: Colors.grey,
        height: ScreenUtil().setWidth(120),
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          fromDate: fromDate,
          bezierChartScale: BezierChartScale.WEEKLY,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              lineColor: Color(0xff007BEF),
              label: "Duty",
              onMissingValue: (dateTime) {
                if (dateTime.day.isEven) {
                  return 10.0;
                }
                return 5.0;
              },
              data: [
                DataPoint<DateTime>(value: 10, xAxis: date1),
                DataPoint<DateTime>(value: 50, xAxis: date2),
              ],
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            // backgroundColor: Colors.red,
            // footerHeight: 30.0,
          ),
        ),
      ),
    );
  }

  Column _buildLatesUpdateInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: Text(
              'Covid-19 Last Update',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(23),
                  fontWeight: FontWeight.bold),
            )),
        SizedBox(
          height: ScreenUtil().setWidth(15),
        ),
        Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Last update 25 Mar 20 . 16.37 WIB',
                    style: TextStyle(
                        color: Color(0xffC8D0DE),
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.bold)),
                Text('Details',
                    style: TextStyle(
                        color: Color(0xff0577F0),
                        fontSize: ScreenUtil().setSp(13),
                        fontWeight: FontWeight.bold)),
              ],
            )),
        SizedBox(
          height: ScreenUtil().setWidth(30),
        ),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCardStatusCovid(790, Color(0xffFE9658), Color(0xffFFF1E6),
                Icons.add, 'infected'),
            _buildCardStatusCovid(31, Color(0xff06B871), Color(0xffE5F9F2),
                Icons.favorite, 'recorvered'),
            _buildCardStatusCovid(58, Color(0xffFF3334), Color(0xffFFEAEB),
                Icons.close, 'deaths'),
            // Text('recovered'),
            // Text('deaths'),
          ],
        )),
      ],
    );
  }

  Card _buildCardStatusCovid(int counter, Color color1, Color color2,
      IconData iconData, String title) {
    return Card(
      color: Colors.white,
      child: Container(
        width: ScreenUtil().setWidth(120),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setWidth(30),
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(3)),
              decoration: BoxDecoration(shape: BoxShape.circle, color: color2),
              child:
                  Icon(iconData, color: color1, size: ScreenUtil().setSp(18)),
            ),
            SizedBox(
              height: ScreenUtil().setWidth(15),
            ),
            Text(
              counter.toString(),
              style: TextStyle(
                  color: color1,
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold),
            ),
            Text(title.toUpperCase(),
                style: TextStyle(
                    color: Color(0xffABB7C9),
                    fontSize: ScreenUtil().setSp(9),
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: ScreenUtil().setWidth(30),
            ),
          ],
        ),
      ),
    );
  }

  Align _buildBanner(Size size, BuildContext context) => Align(
        alignment: Alignment.centerRight,
        child: Hero(
          tag: 'background',
          child: Card(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(3),
            // ),
            elevation: 15,
            margin: EdgeInsets.only(right: 0),
            child: GestureDetector(
              onTap: () {
                Routes.sailor.navigate(
                  '/question',
                  transitions: [
                    SailorTransition.fade_in,
                  ],
                  transitionDuration: Duration(milliseconds: 600),
                  transitionCurve: Curves.bounceOut,
                );
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    // borderRadius: BorderRadius.circular(3),
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(3))
                  ),
                  height: ScreenUtil().setWidth(135),
                  width: size.width - ScreenUtil().setWidth(18),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          bottom: ScreenUtil().setWidth(62),
                          left: ScreenUtil().setWidth(15),
                          child: _buildDotCovid(6, 6)),
                      Positioned(
                          bottom: ScreenUtil().setWidth(82),
                          left: ScreenUtil().setWidth(18),
                          child: _buildDotCovid(9, 9)),
                      Positioned(
                          bottom: ScreenUtil().setWidth(70),
                          left: ScreenUtil().setWidth(40),
                          child: _buildDotCovid(6, 6)),
                      Positioned(
                          bottom: ScreenUtil().setWidth(90),
                          left: ScreenUtil().setWidth(60),
                          child: _buildDotCovid(5, 5)),
                      Positioned(
                          bottom: ScreenUtil().setWidth(50),
                          left: ScreenUtil().setWidth(70),
                          child: _buildDotCovid(10, 10)),
                      Positioned(
                          bottom: ScreenUtil().setWidth(-23),
                          left: ScreenUtil().setWidth(-25),
                          child: SvgPicture.asset('assets/images/virus.svg',
                              height: ScreenUtil().setWidth(85),
                              semanticsLabel: 'Acme Logo')),
                      Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            width: ScreenUtil().setWidth(85),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Self Check Up Covid-19',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setWidth(10),
                                ),
                                Text(
                                  'Contain several list of question to check your physical condition.',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                            child: Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 16),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(30),
                          )
                        ],
                      )),
                    ],
                  )),
            ),
          ),
        ),
      );

  Container _buildDotCovid(double height, double width) {
    return Container(
      height: ScreenUtil().setWidth(height),
      width: ScreenUtil().setWidth(width),
      decoration:
          BoxDecoration(color: Color(0xff7A3E55), shape: BoxShape.circle),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(18)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: ScreenUtil().setWidth(30),
              ),
              Container(
                  child: Text(
                'Current outbreak',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: ScreenUtil().setWidth(5),
              ),
              Container(
                  child: Text('Indonesia',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(38),
                          fontWeight: FontWeight.bold))),
              SizedBox(
                height: ScreenUtil().setWidth(5),
              ),
              Container(
                  child: Text(
                'Wed, 25 Mar 20',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(15), color: Color(0xff8E9EB5)),
              )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(18)),
            child: Stack(
              children: <Widget>[
                Icon(
                  Icons.notifications,
                  color: Color(0xffA7B4C9),
                  size: ScreenUtil().setSp(35),
                ),
                Positioned(
                  top: 2,
                  right: 3,
                  child: Container(
                    height: ScreenUtil().setWidth(12),
                    width: ScreenUtil().setWidth(12),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
