import 'package:farozamartapp/base_page.dart';
import 'package:farozamartapp/core/auth_state.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String routeName = '/profile/';

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(title: 'Profile', body: layout(context));
  }
}

Widget layout(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
  Widget largeScreens = ListView(
    children: [
      Card(
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: screenSize.height / 4,
                  maxWidth: screenSize.width / 4),
              child: Image.asset(
                'images/default.png',
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
                child: Column(
              children: [Text('Username'), Text('Full name')],
            ))
          ],
        ),
      ),
      Card(
        child: Column(children: [Text('Orders'), orders()]),
      )
    ],
  );
  if (screenSize.width < 800) {
    return largeScreens;
  } else {
    return largeScreens;
  }
}

Widget orders() {
  return Column(
    children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text('ID'), Text('Approved')])
    ],
  );
}
