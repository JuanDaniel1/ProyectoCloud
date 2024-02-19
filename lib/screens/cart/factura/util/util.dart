import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';


Future<Uint8List> generatePdf(final PdfPageFormat format) async{
  final doc = pw.Document(
    title: "Factura"
  );
  final logoImage = pw.MemoryImage(
      (await rootBundle.load("assets/sena.png")).buffer.asUint8List()
  );

  final pageTheme = await _myPageTheme(format);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
    header: (final context) => pw.Image(
      alignment: pw.Alignment.topLeft,
      logoImage,
      fit: pw.BoxFit.contain,
      width: 100

    )

    , build: (final context)=> [
      pw.Container(
        padding: pw.EdgeInsets.only(left: 30, bottom: 20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text('Email: '),
                pw.Text('Telefono: '),
                pw.Text('Instagram: ')
              ]
            ),
            pw.SizedBox(width: 70),
          pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('sena@misena.com'),
              pw.Text('032131 03123'),
            ]
      ),
            pw.SizedBox(width: 70),
            pw.BarcodeWidget(
              data: "Factura",
              width: 40,
              height: 40,
              barcode: pw.Barcode.qrCode(),
              drawText: false
            ),
            pw.Padding(padding: pw.EdgeInsets.zero)
          ]
        )
      ),
      pw.Center(
        child: pw.Text('Factura', textAlign: pw.TextAlign.center, )
      )
    ]
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async{
  final logoImage = pw.MemoryImage(
      (await rootBundle.load("assets/sena.png")).buffer.asUint8List()
  );
  return pw.PageTheme(
    margin: const pw.EdgeInsets.symmetric(
      horizontal: 1 * PdfPageFormat.cm, vertical: 0.5 * PdfPageFormat.cm
    ),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
    buildBackground: (final context) =>
        pw.FullPage(
          ignoreMargins: true,
          child: pw.Watermark(
            angle: 20,
            child: pw.Opacity(
              opacity: 0.5,
              child: pw.Image(
                alignment: pw.Alignment.center,
                logoImage,
                fit: pw.BoxFit.cover
              )
            )
          )
        )
  );
}

Future<void> saveAsFile(
final BuildContext context,
final LayoutCallback build,
final PdfPageFormat pageFormat
)async{
  final bytes = await build(pageFormat);
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/document.pdf');
  print('save as file ${file.path}...');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Factura impresa correctamente'))
  );
}

void showSharedToast(final BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Factura compartida correctamente'))
  );
}