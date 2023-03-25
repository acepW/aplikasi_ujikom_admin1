import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class printAduan {
  Future<void> AduanPrint(String nama, DateTime tanggal, String statusss,
      String judul, String deskripsi, String imagee) async {
    final doc = pw.Document();

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
              padding: pw.EdgeInsets.all(10),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Container(
                        child: pw.Center(
                            child: pw.Text("Laporan Pengaduan User",
                                style: pw.TextStyle(
                                    fontSize: 30,
                                    fontWeight: pw.FontWeight.bold)))),
                    pw.SizedBox(height: 50),
                    pw.Container(
                        child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text("Nama",
                                style: pw.TextStyle(fontSize: 20)),
                          ),
                          pw.SizedBox(
                            width: 30,
                          ),
                          pw.Text(nama, style: pw.TextStyle(fontSize: 20)),
                        ])),
                    pw.SizedBox(height: 30),
                    pw.Container(
                        child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text("Tanggal",
                                style: pw.TextStyle(fontSize: 20)),
                          ),
                          pw.SizedBox(
                            width: 30,
                          ),
                          pw.Text(DateFormat.yMd().add_jm().format(tanggal),
                              style: pw.TextStyle(fontSize: 20)),
                        ])),
                    pw.SizedBox(height: 30),
                    pw.Container(
                        child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text("Status",
                                style: pw.TextStyle(fontSize: 20)),
                          ),
                          pw.SizedBox(
                            width: 30,
                          ),
                          pw.Text(statusss, style: pw.TextStyle(fontSize: 20)),
                        ])),
                    pw.SizedBox(height: 30),
                    pw.Container(
                        child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text("Judul",
                                style: pw.TextStyle(fontSize: 20)),
                          ),
                          pw.SizedBox(
                            width: 30,
                          ),
                          pw.Text(judul, style: pw.TextStyle(fontSize: 20)),
                        ])),
                    pw.SizedBox(height: 30),
                    pw.Container(
                        child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                          pw.Container(
                            width: 100,
                            child: pw.Text("Deskripsi",
                                style: pw.TextStyle(fontSize: 20)),
                          ),
                          pw.SizedBox(
                            width: 30,
                          ),
                          pw.Text(deskripsi, style: pw.TextStyle(fontSize: 20)),
                        ])),
                    pw.SizedBox(height: 30),
                  ])); // Center
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
