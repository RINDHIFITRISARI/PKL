import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemberitahuan Cuti Berhasil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CutiBerhasilPage(),
    );
  }
}

class CutiBerhasilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pemberitahuan Cuti Berhasil'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Selamat! Permintaan cuti Anda telah berhasil diajukan dan sedang diproses.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              buildDetailItem('Nama Karyawan:', 'Anisa Rahmawati'),
              buildDetailItem('Tanggal Mulai Cuti:', '28 Februari 2024'),
              buildDetailItem('Tanggal Selesai Cuti:', '4 Maret 2024'),
              buildDetailItem('Jumlah Hari Cuti:', '5 hari'),
              buildDetailItem('Alasan Cuti:', 'Sakit'),
              SizedBox(height: 20.0),
              Text(
                'Kami akan segera memproses permintaan cuti Anda. Mohon tunggu konfirmasi lebih lanjut dari tim HR atau atasan Anda.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Terima kasih telah menggunakan sistem cuti kami.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
