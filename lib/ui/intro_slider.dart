import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/ui/personal_list.dart';
import 'package:flutter_todo/utils/CommonMethods.dart';

class IntroSlider extends StatefulWidget {
  @override
  _IntroSliderState createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider>
    with TickerProviderStateMixin {
  double height = 0;
  PageController _pageController = new PageController(initialPage: 0);
  double currentPage = 0.0;
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _managePageController();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _animation = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: PageView(
              controller: _pageController,
              children: [
                //screen 1
                introScreenOne(_pageController),
                //screen 2
                introScreenTwo(context),
                //screen 3
                introScreenThree(context),
                //Screen 4
                introScreenFour()
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: DotsIndicator(
                      dotsCount: 4,
                      position: currentPage,
                    ),
                  ),
                  currentPage == 1
                      ? AnimatedBuilder(
                          animation: _animation,
                          builder: (BuildContext context, Widget child) {
                            return Expanded(
                              flex: 8,
                              child: Container(
                                child: Image.asset('assets/mobile_screen.png'),
                              ),
                            );
                          })
                      : Container()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _managePageController() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
      if (_pageController.page == 2.0) {

        setState(() {
          height = _pageController.position.pixels / 2;
        });
        _controller.forward(from: 0.0);
      }else{
        setState(() {
          height = 0.0;
        });
      }
      if (_pageController.page > 2) {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => PersonalList()));
      }
    });
  }
}
