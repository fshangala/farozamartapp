import 'package:farozamartapp/widgets/get_image_from_network.dart';
import 'package:farozamartapp/core/functions.dart';
import 'package:farozamartapp/core/models/listing.dart';
import 'package:farozamartapp/listing_page.dart';
import 'package:farozamartapp/widgets/not_null_future_renderer.dart';
import 'package:flutter/material.dart';
import 'package:farozamartapp/base_page.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Listing listingApi = Listing();
  Future<List<ListingObject>> listingFuture = Future.value([]);

  @override
  void initState() {
    super.initState();
    listingFuture = listingApi.listing();
  }

  void getListing() {
    setState(() {
      listingFuture = listingApi.listing();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Home',
      body: RefreshIndicator(
        onRefresh: () async {
          getListing();
        },
        child: ListView(
          children: [
            _layout(listingFuture, getListing),
          ],
        ),
      ),
    );
  }

  Widget _layout(
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
}

Widget _buildButtonColumn(
    {required Color color,
    required IconData icon,
    required String label,
    required void Function() onPressed}) {
  return TextButton(
      onPressed: onPressed,
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
        return const Column(
          children: [
            Text('No products to show'),
          ],
        );
      }
      return Column(
        children: [
          Column(
            children: listing
                .map(
                  (e) => Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: screenSize.height / 4,
                              maxWidth: screenSize.width / 4),
                          child: getImageFromNetwork(
                              "${Listing().baseUrl}${e.picture}"),
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      icon: Icons.shopping_bag,
                                      label: 'View',
                                      onPressed: () {
                                        goTo(
                                          context: context,
                                          page: ListingPage(id: e.id),
                                        );
                                      },
                                    ),
                                    Text(e.price),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      );
    },
  );
}
