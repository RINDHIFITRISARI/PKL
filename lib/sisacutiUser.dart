import 'package:flutter/material.dart';

class SisaCutiUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuti Tahunan Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SisaCutiUser(),
    );
  }
}

class SisaCuti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Cuti Tahunan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sisa Cuti Tahunan',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: karyawanList.length,
                itemBuilder: (BuildContext context, int index) {
                  final karyawan = karyawanList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            karyawan.nama,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Sisa Cuti: ${karyawan.sisaCuti} hari'),
                          SizedBox(height: 10.0),
                          Text(
                            'Riwayat Cuti:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: karyawan.riwayatCuti
                                .map(
                                  (riwayat) => Text(
                                    '${riwayat.tanggal}: ${riwayat.keterangan} - ${riwayat.disetujui ? "Disetujui" : "Tidak disetujui"}',
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Karyawan {
  final int? id;
  final String nama;
  final String alamat;
  final String devisi;
  final int sisaCuti; // Menyimpan sisa cuti untuk setiap karyawan
  final List<RiwayatCuti>
      riwayatCuti; // Menyimpan riwayat cuti untuk setiap karyawan

  const Karyawan({
    this.id,
    required this.nama,
    required this.alamat,
    required this.devisi,
    required this.sisaCuti,
    required this.riwayatCuti,
  });
}

class RiwayatCuti {
  final String tanggal;
  final String keterangan;
  final bool disetujui; // Menyimpan informasi apakah cuti disetujui atau tidak

  const RiwayatCuti({
    required this.tanggal,
    required this.keterangan,
    required this.disetujui,
  });
}

// Data karyawan
final List<Karyawan> karyawanList = [
  Karyawan(
    id: null,
    nama: "Anisa Rahmawati",
    alamat: "Jl. Krakatau No. 08",
    devisi: "Data Analyst",
    sisaCuti: 18, // Sisa cuti untuk Anisa Rahmawati
    riwayatCuti: [
      RiwayatCuti(
          tanggal: '10 Februari 2024',
          keterangan: 'Cuti Tahun Baru Imlek',
          disetujui: true),
    ],
  ),
];
