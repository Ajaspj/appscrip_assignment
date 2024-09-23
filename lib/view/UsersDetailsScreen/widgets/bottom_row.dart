import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class ButtonRow extends StatelessWidget {
  final Map<String, dynamic> user;

  const ButtonRow({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.print, color: Colors.indigo),
          onPressed: () async {
            await _printUserDetails(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.save, color: Colors.indigo),
          onPressed: () async {
            await _saveUserDetails(context);
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.indigo),
          onPressed: () {
            Share.share(
                'Check out this user: ${user['name']} - ${user['email']}');
          },
        ),
      ],
    );
  }

  Future<void> _printUserDetails(BuildContext context) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        final pdf = pw.Document();

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return _buildPdfContent();
            },
          ),
        );
        return pdf.save();
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Printing User: ${user['name']}')),
    );
  }

  Future<void> _saveUserDetails(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return _buildPdfContent();
        },
      ),
    );

    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/user_details_${user['name']}.pdf';

      final file = File(path);
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved at $path')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error saving PDF')),
      );
    }
  }

  pw.Widget _buildPdfContent() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('User Details',
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 20),
        _buildPdfRow('Name', user['name']),
        _buildPdfRow('Username', user['username']),
        _buildPdfRow('Email', user['email']),
        _buildPdfRow('Phone', user['phone']),
        _buildPdfRow('Website', user['website']),
        pw.SizedBox(height: 20),
        pw.Text('Address',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        _buildPdfRow('Street', user['address']['street']),
        _buildPdfRow('Suite', user['address']['suite']),
        _buildPdfRow('City', user['address']['city']),
        _buildPdfRow('Zipcode', user['address']['zipcode']),
        pw.SizedBox(height: 20),
        pw.Text('Company',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        _buildPdfRow('Company Name', user['company']['name']),
        _buildPdfRow('Catchphrase', user['company']['catchPhrase']),
        _buildPdfRow('Business', user['company']['bs']),
      ],
    );
  }

  pw.Widget _buildPdfRow(String label, String value) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('$label: ',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Expanded(child: pw.Text(value)),
      ],
    );
  }
}
