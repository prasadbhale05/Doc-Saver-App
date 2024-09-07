import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class DocViewScreen extends StatefulWidget {
  static String routeName = '/docViewScreen';
  const DocViewScreen({super.key});

  @override
  State<DocViewScreen> createState() => _DocViewScreenState();
}

class _DocViewScreenState extends State<DocViewScreen> {
  PDFDocument? doc;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DocViewScreenArgs;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.fileName),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PDFViewer(
              document: snapshot.requireData,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        future: getDocumentData(args),
      ),
    );
  }

  Future<PDFDocument> getDocumentData(
      DocViewScreenArgs docViewScreenArgs) async {
    // To store downloaded file in a particular path in our device!
    doc = await PDFDocument.fromURL(docViewScreenArgs.fileUrl);
    return doc ?? PDFDocument();
  }
}

class DocViewScreenArgs {
  final String fileUrl, fileName, fileType;
  DocViewScreenArgs({
    required this.fileUrl,
    required this.fileName,
    required this.fileType,
  });
}
