import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';




Future<pw.PageTheme> myPageTheme(PdfPageFormat format) async{
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
              opacity: 0.1,
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