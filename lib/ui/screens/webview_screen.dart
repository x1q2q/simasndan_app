import 'package:flutter/material.dart';
import '../components/def_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/api.dart';

class WebviewScreen extends StatefulWidget {
  final String? urlWeb;
  WebviewScreen({super.key, this.urlWeb});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController controller;
  @override
  void initState() {
    String newUrl = widget.urlWeb ?? Api.baseURL;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (navigation) {
            if (navigation.url != newUrl) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(newUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const DefAppBar(title: ""),
            backgroundColor: Colors.white,
            body: WebViewWidget(controller: controller)));
  }
}
