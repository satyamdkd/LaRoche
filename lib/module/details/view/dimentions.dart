import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:laroch/const/common_lib.dart';

class Dimentions extends StatefulWidget {
  String? url='';
   Dimentions({super.key, this.url});

  @override
  State<Dimentions> createState() => _DimentionsState();
}


class _DimentionsState extends State<Dimentions> {
  bool _isLoading = true;
  late PDFDocument document;
  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(widget.url!);

    setState(() => _isLoading = false);
  }
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(),
      body:
      // PDFView(
      //   filePath: "https://www.larochenigeria.com/shop/img/product-docs/Product51588_20220318.pdf",
      //   autoSpacing: true,
      //   enableSwipe: true,
      //   pageSnap: true,
      //   swipeHorizontal: true,
      //   onError: (error) {
      //     print(error);
      //   },
      //   onPageError: (page, error) {
      //     print('$page: ${error.toString()}');
      //   },
      //   onViewCreated: (PDFViewController vc) {
      //     pdfViewController = vc;
      //   },
      //   // onPageChanged: (int page, int total) {
      //   //   print('page change: $page/$total'),
      //   // },
      // ),


      _isLoading
          ? Center(child: CircularProgressIndicator(color: appColors.red,)): PDFViewer(
      document: document,
      lazyLoad: false,
        zoomSteps: 1,
        numberPickerConfirmWidget: const Text(
        "Confirm",
    ),)
    );
  }
}
