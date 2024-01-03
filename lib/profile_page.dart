import 'package:farozamartapp/base_page.dart';
import 'package:farozamartapp/core/auth_state.dart';
import 'package:farozamartapp/core/functions.dart';
import 'package:farozamartapp/core/models/user.dart';
import 'package:farozamartapp/core/resolve_future.dart';
import 'package:farozamartapp/home_page.dart';
import 'package:farozamartapp/widgets/null_future_renderer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String routeName = '/profile/';

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends AuthState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: 'Profile',
        body: NullFutureRenderer(
          future: userFuture,
          futureRenderer: (userObject) {
            return layout(userObject);
          },
        ));
  }

  Widget layout(UserObject userObject) {
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
                children: [
                  Text(userObject.username),
                  Text('${userObject.firstName} ${userObject.lastName}')
                ],
              ))
            ],
          ),
        ),
        Card(
          child: Column(children: [const Text('Orders'), orders()]),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              resolveFuture(
                context,
                userApi.logout(),
                (value) {
                  if (value) {
                    goTo(
                      context: context,
                      page: const HomePage(),
                      permanent: true,
                    );
                  }
                },
              );
            },
            child: const Text('Logout'),
          ),
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
    return const Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text('ID'), Text('Approved')])
      ],
    );
  }
}
