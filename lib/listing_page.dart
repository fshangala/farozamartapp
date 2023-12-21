import 'package:farozamartapp/base_page.dart';
import 'package:farozamartapp/core/auth_state.dart';
import 'package:farozamartapp/core/models/listing.dart';
import 'package:farozamartapp/widgets/add_to_cart_form.dart';
import 'package:farozamartapp/widgets/null_future_renderer.dart';
import 'package:flutter/material.dart';

class ListingPage extends StatefulWidget {
  final int id;
  const ListingPage({super.key, required this.id});
  static String routeName = '/listing/';

  @override
  State<StatefulWidget> createState() => _ListingPageState();
}

class _ListingPageState extends AuthState<ListingPage> {
  var listingApi = Listing();
  Future<ListingObject?> listingFuture = Future.value(null);

  @override
  void afterInit() {
    listingFuture = listingApi.singleListing(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Listing',
      body: RefreshIndicator(
        onRefresh: () async {
          getUser();
          listingFuture = listingApi.singleListing(widget.id);
        },
        child: NullFutureRenderer(
          future: userFuture,
          futureRenderer: (userObject) {
            return layout();
          },
        ),
      ),
    );
  }

  Widget layout() {
    var screenSize = MediaQuery.of(context).size;
    Widget largeScreens = ListView(
      children: [
        NullFutureRenderer(
          future: listingFuture,
          futureRenderer: (listingObject) {
            return Column(
              children: [
                Card(
                  child: Row(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: screenSize.height / 4,
                          maxWidth: screenSize.width / 4,
                        ),
                        child: Image.network(
                          '${listingApi.baseUrl}${listingObject.picture}',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(listingObject.name),
                            Text(listingObject.price),
                            AddToCartForm(product: listingObject),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Text(listingObject.description),
                ),
              ],
            );
          },
        )
      ],
    );
    if (screenSize.width < 800) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: largeScreens,
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: screenSize.width / 5),
        child: largeScreens,
      );
    }
  }
}
