import 'package:farozamartapp/core/auth_state.dart';
import 'package:farozamartapp/core/models/listing.dart';
import 'package:farozamartapp/core/models/user.dart';
import 'package:farozamartapp/widgets/not_null_future_renderer.dart';
import 'package:farozamartapp/widgets/null_future_renderer.dart';
import 'package:flutter/material.dart';
import 'package:farozamartapp/base_page.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends AuthState<HomePage> {
  Future<List<ListingObject>> listingFuture = Future.value([]);

  @override
  void initState() {
    super.initState();
    listingFuture = Listing().listing();
  }

  void getListing() {
    setState(() {
      listingFuture = Listing().listing();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Home',
      body: NullFutureRenderer(
        future: userFuture,
        futureRenderer: (userObject) => ListView(
          children: [_layout(context, userObject, listingFuture, getListing)],
        ),
      ),
    );
  }
}

Widget _layout(BuildContext context, UserObject userObject,
    Future<List<ListingObject>> listingFuture, void Function() getListing) {
  var screenSize = MediaQuery.of(context).size;
  if (screenSize.width < 800) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [products(context, listingFuture, getListing)]),
    );
  } else {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenSize.width / 5),
      child: Column(children: [products(context, listingFuture, getListing)]),
    );
  }
}

Widget _buildButtonColumn(Color color, IconData icon, String label) {
  return TextButton(
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400, color: color),
              ),
            )
          ],
        ),
      ));
}

Widget products(BuildContext context, Future<List<ListingObject>> futureListing,
    void Function() getListing) {
  var screenSize = MediaQuery.of(context).size;
  return NotNullFutureRenderer(
      future: futureListing,
      futureRenderer: (listing) {
        if (listing.isEmpty) {
          return Column(
            children: [
              const Text('No products to show'),
              IconButton(
                  onPressed: () {
                    getListing();
                  },
                  icon: const Icon(Icons.replay))
            ],
          );
        }
        return Column(children: [
          Column(
            children: listing
                .map((e) => Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: screenSize.height / 4,
                                maxWidth: screenSize.width / 4),
                            child: Image.network(
                              "${Listing().baseUrl}${e.picture}",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(e.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      _buildButtonColumn(
                                          Theme.of(context).colorScheme.primary,
                                          Icons.add_shopping_cart,
                                          'Add to cart'),
                                      Text(e.price),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          IconButton(
              onPressed: () {
                getListing();
              },
              icon: const Icon(Icons.replay))
        ]);
      });
}
