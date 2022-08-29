import 'package:flutter/material.dart';
import 'package:pdfgenerator/pdfpage.dart';
import 'package:provider/provider.dart';

import 'downloadprovider.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp>  {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => FileDownloaderProvider(),
            child: PdfPage(),
          ),
        ],
        child: MaterialApp(
            title: 'File Downloader',
            debugShowCheckedModeBanner: false,
            home: SafeArea(bottom: false,
                child: Scaffold(
                    primary: false,
                    body: PdfPage()
                )
            )
        )
    );
  }
}