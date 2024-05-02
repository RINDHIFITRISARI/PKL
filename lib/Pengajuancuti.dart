import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:contoh/Pemberitahuancuti.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Pengajuancuti extends StatefulWidget {
  const Pengajuancuti({Key? key}) : super(key: key);

  @override
  State<Pengajuancuti> createState() => PengajuancutiState();
}

class PengajuancutiState extends State<Pengajuancuti> {
  FilePickerResult? result;
  bool isLoading = false;
  File? fileToDisplay;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String description = '';
  String uploadedFileName = '';

  Future<void> funcAmbilFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      fileToDisplay = File(result.files.first.path!);
      uploadedFileName = result.files.first.name;
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  Future<void> pickStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  void pickEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  void uploadFile() async {
    // Implement file uploading logic here
    // Example: You can use packages like file_picker to select files
    // For simplicity, let's assume the file name is "example.pdf"
    setState(() {
      uploadedFileName = "example.pdf";
    });
  }

  void showConfirmationDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: 'Konfirmasi',
      desc: 'Anda yakin ingin mengajukan permintaan cuti?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        submitForm();
      },
    )..show();
  }

  void submitForm() {
    // Proses pengajuan cuti di sini
    // Misalnya, mengirim data ke server atau melakukan tindakan lainnya

    // Setelah proses berhasil, bisa menampilkan pesan sukses atau redirect ke halaman lain
    // Misalnya:
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => CutiBerhasilPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pengajuan Cuti'),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 30),
                const Text(
                  'FORM PENGAJUAN CUTI TAHUNAN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                ListTile(
                  title: const Text('Tanggal Mulai:'),
                  subtitle: Text(
                    '${startDate.day}-${startDate.month}-${startDate.year}',
                  ),
                  onTap: () {
                    pickStartDate(context);
                  },
                ),
                ListTile(
                  title: const Text('Tanggal Selesai:'),
                  subtitle: Text(
                    '${endDate.day}-${endDate.month}-${endDate.year}',
                  ),
                  onTap: () {
                    pickEndDate(context);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Keterangan'),
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await funcAmbilFile();
                  },
                  child: const Text('Unggah File'),
                ),
                if (fileToDisplay != null)
                  Image.file(
                    fileToDisplay!,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 400,
                  ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    showConfirmationDialog();
                  },
                  child: const Text('Ajukan Permintaan Cuti'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
