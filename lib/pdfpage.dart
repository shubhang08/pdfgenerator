import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pdfapi.dart';
import './main.dart';
import './button.dart';
import 'downloadprovider.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  static final String title = 'Generate PDF';


  @override
  Widget build(BuildContext context) {
    var fileDownloaderProvider =
    Provider.of<FileDownloaderProvider>(context, listen: false);
    return Scaffold(
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
                dowloadButton(fileDownloaderProvider),
                downloadProgress()


              ],
            ),
          ),
        ),
      );}


  Widget dowloadButton(FileDownloaderProvider downloaderProvider) {
    return FlatButton(
      onPressed: () {
        downloaderProvider
            .downloadFile("https://www.clickdimensions.com/links/TestPDFfile.pdf", "pdf.pdf")
            .then((onValue) {});
      },
      textColor: Colors.black,
      color: Colors.redAccent,
      padding: const EdgeInsets.all(8.0),
      child: new Text(
        "Download File",
      ),
    );
  }

  Widget downloadProgress() {
    var fileDownloaderProvider =
    Provider.of<FileDownloaderProvider>(context, listen: true);

    return new Text(
      downloadStatus(fileDownloaderProvider),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  downloadStatus(FileDownloaderProvider fileDownloaderProvider) {
    var retStatus = "";

    switch (fileDownloaderProvider.downloadStatus) {
      case DownloadStatus.Downloading:
        {
          retStatus = "Download Progress : " +
              fileDownloaderProvider.downloadPercentage.toString() +
              "%";
        }
        break;
      case DownloadStatus.Completed:
        {
          retStatus = "Download Completed";
        }
        break;
      case DownloadStatus.NotStarted:
        {
          retStatus = "Click Download Button";
        }
        break;
      case DownloadStatus.Started:
        {
          retStatus = "Download Started";
        }
        break;
    }

    return retStatus;
  }
}
