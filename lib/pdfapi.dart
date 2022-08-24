
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class User {
  final int sno;
  final int date;
  final String day;
  final String Subject;

  const User({

    required this.sno,
    required this.date,
    required this.day,
    required this.Subject,
  });
}

class PdfApi {
  static Future<File> generateTable() async {

    final pdf = Document(
      pageMode: PdfPageMode.fullscreen,
    verbose: true,
    version: PdfVersion.pdf_1_4
    );

    final headers = ['S.NO', 'DATE','DAY','SUBJECT'];

    final users = [
      User(sno:1 , date: 28092022, day: 'MONDAY', Subject: 'ENGLISH'),
      User(sno:2 , date: 28092022, day: 'TUESDAY', Subject: 'Math'),
      User(sno:3 , date: 28092022, day: 'WEDNESDAY', Subject: 'ART'),
      User(sno:4 , date: 28092022, day: 'SATURDAY', Subject: 'HINDI'),
      User(sno:5 , date: 28092022, day: 'MONDAY', Subject: 'SCINCE'),
      User(sno:6 , date: 28092022, day: 'TUESDAY', Subject: 'GEOGRAPHY'),
      User(sno:7 , date: 28092022, day: 'THRUSDAY', Subject: 'SST'),
      User(sno:8 , date: 28092022, day: 'MONDAY', Subject: 'SANSKRIT'),
    ];
    final data = users.map((user) => [user.sno, user.date,user.day,user.Subject]).toList();
    
    pdf.addPage(MultiPage(build: (context)=><Widget>[
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: PdfColors.lightGreenAccent100
      ),
        child:
        Row(
            children: <Widget>[
              Container(
                  child:  PdfLogo(),
                  width: 80,
                  height: 80
              ),
              // SizedBox(width:10),
              Container(
                width: 400,
                  child: Center(child:
                  Text('CARE PUBLIC SCHOOL NEW DELHI',overflow: TextOverflow.visible  ,style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.lightGreen400
                  ),
                      textAlign: TextAlign.center),
                  )

              ),

            ]
        ),
      ),


      SizedBox(height: 15),

      Center(child:   Container(
        height: 40,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        child: Text('Half Yearly Examination Date Sheet class-1 A (2022-2023)', overflow: TextOverflow.visible, textAlign: TextAlign.center, style: TextStyle(
          fontSize: 16,
        )
        ),
        decoration: BoxDecoration(
            color: PdfColors.lightGreenAccent100
        ),
      ),
      ),
      SizedBox(height: 15),
      Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        child: Table.fromTextArray(
            headers: headers,
            data: data,
            cellHeight: 40,
            cellAlignment: Alignment.center,
            headerHeight: 30,
            cellStyle: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 17
            )

        ),
      ),

      SizedBox(height: 20),

      Center(
        child: Text('Note:- Students can leave the school on completion of their exam after 11:15 am after showing I-card at the school gate no. 4',textAlign: TextAlign.center)
      ),
    ]));


    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();


    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
