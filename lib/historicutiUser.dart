import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Histori Cuti',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CutiHistoryPage(),
    );
  }
}

class CutiHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histori Cuti Anisa Rahmawati'),
      ),
      body: ListView(
        children: <Widget>[
          CutiCard(
            nama: "Anisa Rahmawati",
            alamat: "Jl. Krakatau No. 08",
            devisi: "Data Analyst",
            sisaCutiTahunan: 5,
            tanggalMulai: DateTime(2024, 3, 2),
            tanggalSelesai: DateTime(2024, 3, 6),
            keterangan: "Cuti tahunan pertama",
            imageUrl:
                "https://img.freepik.com/free-photo/portrait-beautiful-business-woman-with-glasses-3d-rendering_1142-54789.jpg?t=st=1714092372~exp=1714095972~hmac=169fa2723db58c1b43f1ac56e022a24a62cd053b61ceb6c3612888246ce3f3ce&w=740",
          ),
        ],
      ),
    );
  }
}

class CutiCard extends StatelessWidget {
  final String nama;
  final String alamat;
  final String devisi;
  final int sisaCutiTahunan;
  final DateTime tanggalMulai;
  final DateTime tanggalSelesai;
  final String keterangan;
  final String imageUrl;

  const CutiCard({
    Key? key,
    required this.nama,
    required this.alamat,
    required this.devisi,
    required this.sisaCutiTahunan,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.keterangan,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 30,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('Devisi: $devisi'),
                  Text('Alamat: $alamat'),
                  Text('Tanggal Mulai: ${_formatDate(tanggalMulai)}'),
                  Text('Tanggal Selesai: ${_formatDate(tanggalSelesai)}'),
                  Text('Sisa Cuti Tahunan: $sisaCutiTahunan'),
                  Text('Keterangan: $keterangan'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
