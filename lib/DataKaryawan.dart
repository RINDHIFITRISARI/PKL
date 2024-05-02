import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'HistoryCuti.dart';
import 'package:contoh/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://spjdbxrtidsyqfjbocqk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNwamRieHJ0aWRzeXFmamJvY3FrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0MDQyOTcsImV4cCI6MjAyNTk4MDI5N30.3FPicSbCvJzWEImz5W7byknO5YF_on80rnUuyqJNXI0',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PgeHistory(),
    );
  }
}

class PgeHistory extends StatefulWidget {
  const PgeHistory({Key? key}) : super(key: key);

  @override
  State<PgeHistory> createState() => PgeHistoryState();
}

class PgeHistoryState extends State<PgeHistory> {
  TextEditingController textController = TextEditingController();
  List<Karyawan> karyawanList = [
    Karyawan(
      id: 1,
      nama: "Setiawan Budi",
      alamat: "Jl. Hiri Raya No. 10",
      devisi: "Pemrograman",
    ),
    Karyawan(
      id: 2,
      nama: "Anisa Rahmawati",
      alamat: "Jl. Krakatau No. 08",
      devisi: "Data Analyst",
    ),
    Karyawan(
      id: 3,
      nama: "Rizky Pratama",
      alamat: "Jl. Plewan No. 12",
      devisi: "UX/UI Designer",
    ),
    Karyawan(
      id: 4,
      nama: "Bayu Pramana",
      alamat: "Jl. Sanggrahan No. 15",
      devisi: "Mobile App Developer",
    ),
    Karyawan(
      id: 5,
      nama: "Dita Puspitasari",
      alamat: "Jl. Medoho No. 18",
      devisi: "Web Developer",
    ),
    Karyawan(
      id: 6,
      nama: "Ricky Prasetyo",
      alamat: "Jl. Jolotundo No. 05",
      devisi: "Software Developer",
    ),
    Karyawan(
      id: 6,
      nama: "Toni Setiawan",
      alamat: "Jl. Anggrek No. 13",
      devisi: "Network Security Analyst",
    ),
  ];

  List<Karyawan> filteredKaryawanList = [];

  final noteStream =
      Supabase.instance.client.from('admin').stream(primaryKey: ['id']);

  @override
  void initState() {
    getallKaryawan();
    filteredKaryawanList = karyawanList;
    super.initState();
    // fetchData();
  }

  Future<void> singOut() async {
    await Supabase.instance.client.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (cotext) => const LoginPage()));
  }

  Future<void> createKaryawan(String nama, String alamat, String devisi) async {
    await Supabase.instance.client.from('admin').insert([
      {'nama': nama, 'alamat': alamat, 'devisi': devisi}
    ]);
  }

  Future<void> updateKaryawan(
      int id, String nama, String alamat, String devisi) async {
    await Supabase.instance.client.from('admin').update(
        {'nama': nama, 'alamat': alamat, 'devisi': devisi}).eq('id', id);
  }

  Future<void> deleteKaryawan(int id) async {
    await Supabase.instance.client.from('admin').delete().eq('id', id);
  }

  getallKaryawan() async {
    var a = await Supabase.instance.client.from('admin').select();
    print(a);
  }

//   Future<void> fetchData() async {
//   final response =
//       await Supabase.instance.client.from('admin').select().execute();
//   if (response.error == null && response.data != null) {
//     List<dynamic> data = response.data as List<dynamic>;
//     setState(() {
//       karyawanList = data.map((item) => Karyawan.fromJson(item)).toList();
//       filteredKaryawanList = List.from(karyawanList);
//     });
//   } else {
//     print('Error fetching data: ${response.error?.message}');
//   }
// }

  void filterSearchResults(String query) {
    List<Karyawan> searchResults = karyawanList
        .where((karyawan) =>
            karyawan.nama.toLowerCase().contains(query.toLowerCase()) ||
            karyawan.alamat.toLowerCase().contains(query.toLowerCase()) ||
            karyawan.devisi.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredKaryawanList = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Karyawan'),
        actions: [
          IconButton(
            onPressed: singOut,
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              onChanged: filterSearchResults,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  onPressed: () {
                    textController.clear();
                    filterSearchResults('');
                  },
                  icon: Icon(Icons.clear),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filteredKaryawanList.length,
                itemBuilder: (context, index) {
                  var karyawan = filteredKaryawanList[index];
                  return DataKaryawanCard(
                    nama: karyawan.nama,
                    alamat: karyawan.alamat,
                    devisi: karyawan.devisi,
                    onDelete: () {
                      setState(() {
                        deleteKaryawan(karyawan.id!);
                        karyawanList.removeAt(index);
                      });
                    },
                    onEdit: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          String editedNama = karyawan.nama;
                          String editedAlamat = karyawan.alamat;
                          String editedDevisi = karyawan.devisi;

                          return AlertDialog(
                            title: Text('Edit Karyawan'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Nama',
                                  ),
                                  controller: TextEditingController(
                                      text: karyawan.nama),
                                  onChanged: (value) {
                                    editedNama = value;
                                  },
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Alamat',
                                  ),
                                  controller: TextEditingController(
                                      text: karyawan.alamat),
                                  onChanged: (value) {
                                    editedAlamat = value;
                                  },
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Devisi',
                                  ),
                                  controller: TextEditingController(
                                      text: karyawan.devisi),
                                  onChanged: (value) {
                                    editedDevisi = value;
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    updateKaryawan(karyawan.id!, editedNama,
                                        editedAlamat, editedDevisi);
                                    karyawan.nama = editedNama;
                                    karyawan.alamat = editedAlamat;
                                    karyawan.devisi = editedDevisi;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryCuti(id: karyawan.id),
                        ),
                      );
                    },
                    karyawanId: karyawan.id!,
                    child: Text('HistoryCuti'),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newNama = '';
              String newAlamat = '';
              String newDevisi = '';

              return AlertDialog(
                title: Text('Add a new Karyawan'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nama',
                      ),
                      onChanged: (value) {
                        newNama = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Alamat',
                      ),
                      onChanged: (value) {
                        newAlamat = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Devisi',
                      ),
                      onChanged: (value) {
                        newDevisi = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        createKaryawan(newNama, newAlamat, newDevisi);
                        karyawanList.add(
                          Karyawan(
                            id: karyawanList.length + 1,
                            nama: newNama,
                            alamat: newAlamat,
                            devisi: newDevisi,
                          ),
                        );
                        filteredKaryawanList = karyawanList;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Karyawan {
  final int? id;
  String nama;
  String alamat;
  String devisi;

  Karyawan(
      {this.id,
      required this.nama,
      required this.alamat,
      required this.devisi});

  factory Karyawan.fromJson(Map<String, dynamic> json) {
    return Karyawan(
      id: json['id'] as int?,
      nama: json['nama'] as String,
      alamat: json['alamat'] as String,
      devisi: json['devisi'] as String,
    );
  }
}

class DataKaryawanCard extends StatelessWidget {
  final int? id;
  final String nama;
  final String alamat;
  final String devisi;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final int karyawanId;
  final VoidCallback onTap;

  const DataKaryawanCard({
    Key? key,
    this.id,
    required this.nama,
    required this.alamat,
    required this.devisi,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
    required this.karyawanId,
    required Text child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama: $nama",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text("Alamat: $alamat"),
              Text("Devisi: $devisi"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // TextButton(
                  //   onPressed: onTap, // Gunakan onTap yang diberikan dari luar
                  //   child: Text('Detail'), // Tombol Detail
                  // ),
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class KaryawanDetail extends StatelessWidget {
//   final CutiHistory karyawan;
//   final int id;

//   const KaryawanDetail({Key? key, required this.karyawan, required this.id})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Karyawan'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "ID Karyawan: $id", // Tampilkan ID Karyawan
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text("Nama: ${karyawan.nama}"),
//             Text("Alamat: ${karyawan.alamat}"),
//             Text("Devisi: ${karyawan.devisi}"),
//             Text("Sisa Cuti Tahunan: ${karyawan.sisaCutiTahunan}"),
//             SizedBox(height: 8),
//             Text(
//               "Tanggal Mulai: ${karyawan.tanggalMulai.day}-${karyawan.tanggalMulai.month}-${karyawan.tanggalMulai.year}",
//             ),
//             Text(
//               "Tanggal Selesai: ${karyawan.tanggalSelesai.day}-${karyawan.tanggalSelesai.month}-${karyawan.tanggalSelesai.year}",
//             ),
//             Text("Keterangan: ${karyawan.keterangan}"),
//             Text("File yang diunggah: ${karyawan.fileName}"),
//           ],
//         ),
//       ),
//     );
//   }
// }
