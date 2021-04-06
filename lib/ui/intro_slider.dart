import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/ui/personal_list.dart';
import 'package:flutter_todo/utils/CommonMethods.dart';

class IntroSlider extends StatefulWidget {
  @override
  _IntroSliderState createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  double height = 0;
  PageController _pageController = new PageController(initialPage: 0);
  PageController _bottomPageController = new PageController(initialPage: 0);
  double currentPage = 0.0;

  @override
  void initState() {
    _managePageController();
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
                IntroScreenOne(_pageController),
                //screen 2
                IntroScreenTwo(context),
                //screen 3
                IntroScreenThree(context),
                //Screen 4
                IntroScreenFour()
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: DotsIndicator(
                      dotsCount: 4,
                      position: currentPage,
                    ),
                  ),
                  currentPage == 0 || currentPage >= 3
                      ? Container()
                      : Expanded(
                    flex: 8,
                    child: PageView(
                      controller: _bottomPageController,
                      children: [
                        Container(
                          color: Colors.red,
                        ),
                        Container(
                          color: Colors.green,
                        ),
                        Container(
                          color: Colors.black,
                        ),
                        Container(
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  )
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
      if (_pageController.page == 2.0 && height == 50) {
        setState(() {
          height = 0.0;
        });
        height = _pageController.position.pixels / 2;
      }
      if (_pageController.page <= 1.0 && _pageController.page <= 3) {
        setState(() {
          height = 0.0;
        });
        height = _pageController.position.pixels;
      } else {
        if (_pageController.page != 0.0 && _pageController.page >= 3.0) {
          height = 50;
        }
      }
      if (_pageController.page > 3) {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => PersonalList()));
      }
    });
  }
}
