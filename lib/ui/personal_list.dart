import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class PersonalList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonalListState();
  }
}

List<Widget> _tempListWidget = [];
List<Widget> _listWidget = [];
int listLength = 8;
int lastActionIndex;
class PersonalListState extends State<PersonalList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tempListWidget.addAll([
        Dismissible(
            direction: DismissDirection.startToEnd,
            key: ObjectKey('1'),
            onDismissed: (direction) {
              performListAction(0);
            },
            child: _listTile(context, 'Swipe to the right to complete!', 1)),
        Dismissible(
            direction: DismissDirection.startToEnd,
            key: ObjectKey('2'),
            onDismissed: (direction) {
              performListAction(1);
              _showSnackBar(context, 'Pull down to create an item');
            },
            child: _listTile(context, 'Pull down to create an item', 2)),
        Dismissible(
            direction: DismissDirection.startToEnd,
            key: ObjectKey('3'),
            onDismissed: (direction) {
              performListAction(2);
              _showSnackBar(context, 'Try pinching two rows apart');
            },
            child: _listTile(context, 'Try pinching two rows apart', 3)),
        Dismissible(
            direction: DismissDirection.startToEnd,
            key: ObjectKey('4'),
            onDismissed: (direction) {
              performListAction(3);
              _showSnackBar(context, 'Try pinching vertically shut');
            },
            child: _listTile(context, 'Try pinching vertically shut', 4)),
        Dismissible(
            direction: DismissDirection.startToEnd,
            key: ObjectKey('5'),
            onDismissed: (direction) {
              performListAction(4);
              _showSnackBar(context, 'Pull up to clear');
            },
            child: _listTile(context, 'Pull up to clear', 5)),
        Dismissible(
            direction: DismissDirection.startToEnd,
            key: ObjectKey('6'),
            onDismissed: (direction) {
              performListAction(5);
              _showSnackBar(context, 'Swipe to left to delete');
            },
            child: _listTile(context, 'Swipe to left to delete', 6)),
        Dismissible(
            direction: DismissDirection.startToEnd,
            key: ObjectKey('7'),
            onDismissed: (direction) {
              performListAction(6);
              _showSnackBar(context, 'Tap and hold to pick me up');
            },
            child: _listTile(context, 'Tap and hold to pick me up', 7)),
        Dismissible(
            direction: DismissDirection.startToEnd,
            key: ObjectKey('8'),
            onDismissed: (direction) {
              performListAction(7);
              _showSnackBar(context, 'Try shaking to undo');
            },
            child: _listTile(context, 'Try shaking to undo', 8))
      ]);
      if (_listWidget.length <listLength) _listWidget = _tempListWidget;
      ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
        if (lastActionIndex !=
            null && _tempListWidget.length<_listWidget.length)
          setState(() {
            _tempListWidget.add(_listWidget.elementAt(lastActionIndex));
          });
      });
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Personal List',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return _tempListWidget.elementAt(index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 1,
                  );
                },
                itemCount: _tempListWidget.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTile(BuildContext context, String text, int index) {
    if (_tempListWidget.length > 0) {
      index = _tempListWidget.length;
    }
    return Container(
        color: index < (listLength / 2)
            ? Colors.red[(listLength - index) * 100]
            : Colors.yellow[(listLength - index) * 100],
        padding: EdgeInsets.all(24.0),
        width: MediaQuery.of(context).size.width,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ));
  }

  void performListAction(int index) {
    switch (index) {
      case 0:
        {
          setState(() {
            _tempListWidget.add(_listWidget.elementAt(0));
          });
        }
    }
    setState(() {
      lastActionIndex = index;
      _tempListWidget.remove(_tempListWidget.elementAt(index));
    });
  }
}

void _showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
