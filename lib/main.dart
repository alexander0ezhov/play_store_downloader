import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import './downloader.dart';

void main() => runApp(const MaterialApp(home: PlayStoreDownloader()));


class PlayStoreDownloader extends StatefulWidget {
  const PlayStoreDownloader({Key? key, this.cookieManager}) : super(key: key);

  final CookieManager? cookieManager;

  @override
  State<PlayStoreDownloader> createState() => _PlayStoreDownloaderState();
}



class _PlayStoreDownloaderState extends State<PlayStoreDownloader> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Play Store Downloader'),
      ),
      body: WebView(
        initialUrl: 'https://play.google.com/',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
      floatingActionButton: downloadButton(),
    );
  }

  Widget downloadButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          return FloatingActionButton(
            onPressed: () {
              controller.data!.runJavascriptReturningResult(downloaderScript);
            },
            child: const Icon(Icons.download),
          );
        });
  }
}
