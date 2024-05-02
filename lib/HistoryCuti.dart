import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuti History',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HistoryCuti(),
    );
  }
}

class Karyawan {
  final String nama;
  final String alamat;
  final String devisi;
  final int sisaCutiTahunan;

  Karyawan({
    required this.nama,
    required this.alamat,
    required this.devisi,
    required this.sisaCutiTahunan,
  });
}

class CutiHistory {
  final String nama;
  final String alamat;
  final String devisi;
  final int sisaCutiTahunan;
  final DateTime tanggalMulai;
  final DateTime tanggalSelesai;
  final String keterangan;
  final String imageUrl; // Mengganti fileName dengan imageUrl

  CutiHistory({
    required this.nama,
    required this.alamat,
    required this.devisi,
    required this.sisaCutiTahunan,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.keterangan,
    required this.imageUrl, // Mengganti fileName dengan imageUrl
  });
}

class HistoryCuti extends StatelessWidget {
  const HistoryCuti({Key? key, int? id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Cuti'),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://img.freepik.com/free-photo/businessman-with-laptop-grey-background-3d-illustration-cartoon-character_1142-39015.jpg?t=st=1714091572~exp=1714095172~hmac=32e519ad5b628c61c483d7f07c6cdf1971391bb45823b10174a2a791bbfd0e14&w=740'), // Ganti dengan URL gambar profil karyawan
        ),
      ),
      body: ListView.builder(
        itemCount: cutiHistoryList.length,
        itemBuilder: (context, index) {
          var history = cutiHistoryList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CutiDetail(history: history),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 3,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(history
                      .imageUrl), // Menggunakan imageUrl dari objek CutiHistory
                ),
                title: Text(history.nama),
                subtitle: Text(
                    '${history.tanggalMulai.day}-${history.tanggalMulai.month}-${history.tanggalMulai.year} to ${history.tanggalSelesai.day}-${history.tanggalSelesai.month}-${history.tanggalSelesai.year}'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CutiDetail extends StatelessWidget {
  final CutiHistory history;

  const CutiDetail({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Cuti'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama: ${history.nama}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text("Alamat: ${history.alamat} | Devisi: ${history.devisi}"),
            SizedBox(height: 16),
            Text(
              "Tanggal Mulai: ${history.tanggalMulai.day}-${history.tanggalMulai.month}-${history.tanggalMulai.year}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Tanggal Selesai: ${history.tanggalSelesai.day}-${history.tanggalSelesai.month}-${history.tanggalSelesai.year}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Keterangan: ${history.keterangan}"),
            SizedBox(height: 8),
            Text("URL Gambar Profil: ${history.imageUrl}"),
          ],
        ),
      ),
    );
  }
}

List<CutiHistory> cutiHistoryList = [
  CutiHistory(
    nama: "Setiawan Budi",
    alamat: "Jl. Hiri Raya No. 10",
    devisi: "Pemrograman",
    sisaCutiTahunan: 10,
    tanggalMulai: DateTime(2024, 2, 1),
    tanggalSelesai: DateTime(2024, 2, 5),
    keterangan: "Cuti tahunan pertama",
    imageUrl:
        'https://img.freepik.com/free-photo/3d-illustration-smiling-cartoon-businessman-grey-suit-tie_1142-51479.jpg?t=st=1714092126~exp=1714095726~hmac=2a58edce526ddc1cac4a7407990a7625f91816aca0297ecca6e08520d46d4e37&w=740', // Ganti dengan URL gambar profil karyawan
  ),
  CutiHistory(
    nama: "Anisa Rahmawati",
    alamat: "Jl. Krakatau No. 08",
    devisi: "Data Analyst",
    sisaCutiTahunan: 5,
    tanggalMulai: DateTime(2024, 3, 2),
    tanggalSelesai: DateTime(2024, 3, 6),
    keterangan: "Cuti tahunan pertama",
    imageUrl:
        'https://img.freepik.com/free-photo/portrait-beautiful-business-woman-with-glasses-3d-rendering_1142-54789.jpg?t=st=1714092372~exp=1714095972~hmac=169fa2723db58c1b43f1ac56e022a24a62cd053b61ceb6c3612888246ce3f3ce&w=740', // Ganti dengan URL gambar profil karyawan
  ),
  CutiHistory(
    nama: "Rizky Pratama",
    alamat: "Jl. Plewan No. 12",
    devisi: "UX/UI Designer",
    sisaCutiTahunan: 0,
    tanggalMulai: DateTime(2024, 4, 10),
    tanggalSelesai: DateTime(2024, 4, 14),
    keterangan: "Cuti tahunan kedua",
    imageUrl:
        'https://img.freepik.com/free-photo/portrait-smiling-young-businessman-glasses-3d-rendering_1142-43378.jpg?t=st=1714092713~exp=1714096313~hmac=7e124a8d3a5f28df5e142f50347d9713dfac6ba573b1f42acbe75afe8ce4ca2a&w=740',
  ),
  CutiHistory(
    nama: "Bayu Pramana",
    alamat: "Jl. Sanggrahan No. 15",
    devisi: "Mobile App Developer",
    sisaCutiTahunan: 3,
    tanggalMulai: DateTime(2024, 6, 5),
    tanggalSelesai: DateTime(2024, 6, 8),
    keterangan: "Cuti tahunan kedua",
    imageUrl:
        'https://img.freepik.com/free-photo/young-man-with-glasses-bow-tie-3d-rendering_1142-43322.jpg?t=st=1714092846~exp=1714096446~hmac=49bf5caf341da1ac1028904ad9b25796b8ee29867415797f5f8f70d72104f99c&w=740',
  ),
  CutiHistory(
    nama: "Dita Puspitasari",
    alamat: "Jl. Medoho No. 18",
    devisi: "Web Developer",
    sisaCutiTahunan: 2,
    tanggalMulai: DateTime(2024, 7, 20),
    tanggalSelesai: DateTime(2024, 7, 25),
    keterangan: "Cuti tahunan kedua",
    imageUrl:
        'https://img.freepik.com/free-photo/beautiful-nurse-white-uniform-3d-rendering-3d-illustration_1142-51178.jpg?t=st=1714092535~exp=1714096135~hmac=47c2bcdda7dea903e6a71b056e7ea4cd4f330615e9827635e5126f0c09265b13&w=740',
  ),
  CutiHistory(
    nama: "Ricky Prasetyo",
    alamat: "Jl. Jolotundo No. 05",
    devisi: "Software Developer",
    sisaCutiTahunan: 4,
    tanggalMulai: DateTime(2024, 8, 15),
    tanggalSelesai: DateTime(2024, 8, 18),
    keterangan: "Cuti tahunan kedua",
    imageUrl:
        'https://img.freepik.com/free-photo/portrait-smiling-businessman-business-suit-3d-rendering_1142-40308.jpg?t=st=1714093585~exp=1714097185~hmac=a0436dcd849ce39b10e52be7eba35e2641df8ed51f9a61daf67a53981c1c4234&w=740',
  ),
  CutiHistory(
    nama: "Toni Setiawan",
    alamat: "Jl. Anggrek No. 13",
    devisi: "Network Security Analyst",
    sisaCutiTahunan: 1,
    tanggalMulai: DateTime(2024, 9, 10),
    tanggalSelesai: DateTime(2024, 9, 14),
    keterangan: "Cuti tahunan kedua",
    imageUrl:
        'https://img.freepik.com/free-photo/3d-illustration-business-man-with-glasses-grey-background-clipping-path_1142-58140.jpg?t=st=1714093081~exp=1714096681~hmac=0086b7b9ac88f9fb09b5d12211ef9e5e4ad69586a2618faf4a61618cfe3be0ff&w=740',
  ),
];
