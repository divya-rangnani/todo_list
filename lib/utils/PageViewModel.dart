import 'package:flutter/cupertino.dart';

class PageViewModel extends StatelessWidget{

  //PageViewModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Welcome to ',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: 'Clear', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '\nTap or Swipe', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' to begin.'),
            ],
          ),
        )
      ],
    );
  }


}