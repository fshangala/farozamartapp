import 'package:farozamartapp/core/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget{
  const WebViewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }

}

class WebViewPageState extends State<WebViewPage> {
  var controller = WebViewController();
  bool loading = false;
  String url = 'https://farozamart.com';

  @override
  void initState() {
    super.initState();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (value){
        showLoading(context);
      },
      onPageFinished: (value) {
        Navigator.pop(context);
      },
      onUrlChange: (urlChange) {
        url = urlChange.url!;
      }
    ));
    controller.loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: WebViewWidget(controller: controller),
    );
  }
}