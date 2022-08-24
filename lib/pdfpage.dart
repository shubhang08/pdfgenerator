import 'package:flutter/material.dart';
import './pdfapi.dart';
import './main.dart';
import './button.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  static final String title = 'Generate PDF';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonWidget(
                  text: 'Table PDF',
                  onClicked: () async {
                    final pdfFile = await PdfApi.generateTable();

                    PdfApi.openFile(pdfFile);
                  },
                ),


              ],
            ),
          ),
        ),
      );
}
