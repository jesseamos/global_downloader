import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/presentation/widgets/custom_appbar.dart';

import 'package:webview_flutter/webview_flutter.dart';

class FlutterwavePaymentWebViewProps {
  final String checkoutUrl;
  final ValueChanged<String> onPaymentComplete;

  const FlutterwavePaymentWebViewProps({
    required this.checkoutUrl,
    required this.onPaymentComplete,
  });
}

class FlutterwavePaymentWebView extends StatefulWidget {
  static const routeName = '/flutterwave-payment-webview';
  final FlutterwavePaymentWebViewProps props;

  const FlutterwavePaymentWebView({required this.props});

  @override
  _FlutterwavePaymentWebViewState createState() =>
      _FlutterwavePaymentWebViewState();
}

class _FlutterwavePaymentWebViewState extends State<FlutterwavePaymentWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            // DETECT REDIRECT URL
            if (url.contains("status=successful") ||
                url.contains("status=failed")) {
              final ref = Uri.parse(url).queryParameters['tx_ref'];
              if (ref != null) {
                widget.props.onPaymentComplete(ref);
              }
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.props.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: WebViewWidget(controller: controller),
    );
  }
}
