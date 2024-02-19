import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:shop_app/screens/cart/factura/util/util.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  PrintingInfo? printingInfo;

  void initState() {
    super.initState();
    _init();
  }
  Future<void>_init()async{
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Factura"),
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        actions: [],
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: generatePdf,
      ),
    );
  }
}
