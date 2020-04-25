import 'package:flutter/material.dart';
import 'package:flutter_covid19/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:swipe_stack/swipe_stack.dart';

class QuestionCounterStream {
  BehaviorSubject<int> _showQuestionCounter = BehaviorSubject<int>.seeded(1);

  Stream<int> get streamQuestionCounter => _showQuestionCounter.stream;
  int get questionCounter => _showQuestionCounter.value;

  void setQuestionCounter(value) {
    _showQuestionCounter.add(value);
  }

  void dispose() {
    _showQuestionCounter.close();
  }
}

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final GlobalKey<SwipeStackState> _swipeKey = GlobalKey<SwipeStackState>();

  QuestionCounterStream _questionCounterStream = QuestionCounterStream();

  double maxProgress = 335;
  int allQuestionCounter = 10;
  int showQuestionCounter = 1;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _questionCounterStream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
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
              body: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    height: size.height / 4.2,
                    width: double.infinity,
                    // color: Colors.red,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: ScreenUtil().setWidth(15)),
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Routes.sailor.pop();
                              }),
                          SizedBox(
                            height: ScreenUtil().setWidth(30),
                          ),
                          ControlledAnimation(
                              delay: Duration(milliseconds: 1000),
                              duration: Duration(milliseconds: 400),
                              tween: Tween(begin: 0.0, end: 1.0),
                              builder: (context, snapshot) {
                                return Opacity(
                                  opacity: snapshot,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(25)),
                                    child: Text("Self Check Up Covid-19",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(16),
                                            fontWeight: FontWeight.bold)),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: ScreenUtil().setWidth(5),
                          ),
                          ControlledAnimation(
                              delay: Duration(milliseconds: 1500),
                              duration: Duration(milliseconds: 400),
                              tween: Tween(begin: 0.0, end: 1.0),
                              builder: (context, snapshot) {
                                return Opacity(
                                  opacity: snapshot,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(25)),
                                    child: Text("Questions",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(40),
                                            fontWeight: FontWeight.bold)),
                                  ),
                                );
                              }),
                          // SizedBox(
                          //   height: ScreenUtil().setWidth(30),
                          // ),
                          // ControlledAnimation(
                          //     // delay: Duration(milliseconds: 1000),
                          //     duration: Duration(milliseconds: 1000),
                          //     tween: Tween(begin: 0.5, end: 1.0),
                          //     builder: (context, value) {
                          //       return Transform.scale(
                          //           scale: value,
                          //           child: _buildProgressQuestion());
                          //     }),
                        ]),
                  ),
                  ControlledAnimation(
                      // delay: Duration(milliseconds: 1000),
                      duration: Duration(milliseconds: 1000),
                      tween: Tween(begin: 0.5, end: 1.0),
                      builder: (context, value) {
                        return Transform.scale(
                            scale: value, child: _buildProgressQuestion());
                      }),
                  SizedBox(
                    height: ScreenUtil().setWidth(15),
                  ),
                  Stack(
                    children: <Widget>[
                      ControlledAnimation(
                          delay: Duration(milliseconds: 2000),
                          duration: Duration(milliseconds: 1300),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value) {
                            return Opacity(
                                opacity: value,
                                child: ControlledAnimation(
                                    delay: Duration(milliseconds: 2000),
                                    duration: Duration(milliseconds: 400),
                                    tween: Tween(
                                        begin: Offset(0, 150),
                                        end: Offset.zero),
                                    builder: (context, offsetValue) {
                                      return Transform.translate(
                                        offset: offsetValue,
                                        child: _swipeStackQuestion(
                                            size, _swipeKey),
                                      );
                                    }));
                          }),
                      // _swipeStackQuestion(size, _swipeKey),
                      Container(
                        height: size.height / 1.6,
                        width: size.width,
                        color: Colors.transparent,
                        child: Column(
                          children: <Widget>[
                            Expanded(child: Text('')),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  elevation: 10,
                                  color: Theme.of(context).cardColor,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    _swipeKey.currentState.swipeLeft();
                                  },
                                  child: Container(
                                      width: size.width / 4,
                                      child: Center(child: Text('No'))),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(25),
                                ),
                                RaisedButton(
                                  elevation: 10,
                                  color: Theme.of(context).cardColor,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    _swipeKey.currentState.swipeRight();
                                  },
                                  child: Container(
                                      width: size.width / 4,
                                      child: Center(child: Text('Yes'))),
                                ),
                              ],
                            ),
                            SizedBox(height: 40)
                          ],
                        ),
                      )
                    ],
                  )
                ]),
              )),
        ],
      ),
    );
  }

  StreamBuilder<Object> _buildProgressQuestion() {
    return StreamBuilder<Object>(
        stream: _questionCounterStream.streamQuestionCounter,
        builder: (context, AsyncSnapshot snapshot) {
          double currentProgress =
              ((snapshot.data / allQuestionCounter) * maxProgress);
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(28)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 5,
                        width: ScreenUtil().setWidth(335),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xff4F556B),
                        ),
                      ),
                      Container(
                        height: 5,
                        width: ScreenUtil().setWidth(currentProgress),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(children: [
                    Text(
                      snapshot.data.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text('/$allQuestionCounter',
                        style: TextStyle(color: Colors.white))
                  ])
                ]),
          );
        });
  }

  Container _swipeStackQuestion(
      Size size, GlobalKey<SwipeStackState> _swipeKey) {
    return Container(
      height: size.height / 1.6,
      width: size.width,
      child: SwipeStack(
        key: _swipeKey,
        children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map((int index) {
          return SwiperItem(
              builder: (SwiperPosition position, double progress) {
            return Material(
                elevation: 4,
                borderRadius: BorderRadius.all(Radius.circular(6)),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Stack(
                      children: <Widget>[
                        _buildBackgroundImage(),
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: ScreenUtil().setWidth(80)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("#kawalcovid-19 #selfcheckup",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10)),
                                SizedBox(
                                  height: ScreenUtil().setWidth(20),
                                ),
                                Text(
                                    "Have you experience any of the following symptoms:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: ScreenUtil().setSp(27),
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: ScreenUtil().setWidth(20),
                                ),
                                Text(
                                    "Fever, Cough, Sneezing, Sore Throat, Difficulty in Breathing Loremipsum dolor.",
                                    style: TextStyle(
                                        color: Color(0xff60677C),
                                        fontSize: ScreenUtil().setSp(18))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )));
          });
        }).toList(),
        visibleCount: 3,
        stackFrom: StackFrom.Bottom,
        translationInterval: 6,
        scaleInterval: 0.03,
        onEnd: () => debugPrint("onEnd"),
        onSwipe: (int index, SwiperPosition position) {
          debugPrint("onSwipe $index $position");
          // setState(() {
          if (_questionCounterStream.questionCounter < allQuestionCounter) {
            _questionCounterStream
                .setQuestionCounter(_questionCounterStream.questionCounter + 1);
          }

          // });
        },
        onRewind: (int index, SwiperPosition position) =>
            debugPrint("onRewind $index $position"),
      ),
    );
  }

  Positioned _buildBackgroundImage() {
    return Positioned(
      top: -30,
      right: -30,
      child: Opacity(
        opacity: 0.1,
        child: SvgPicture.asset('assets/images/virus_bw.svg',
            height: ScreenUtil().setWidth(120), semanticsLabel: 'Acme Logo'),
      ),
    );
  }
}
