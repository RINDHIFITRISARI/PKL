import 'package:contoh/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://juotgmqnlodflzftrgvy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp1b3RnbXFubG9kZmx6ZnRyZ3Z5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ2Mzg3NTksImV4cCI6MjAzMDIxNDc1OX0.tKD2lbkOFsvLZwEWNFn_yL8I6dL6G_vQo3A2rJa7AGI',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KaryawanPage(),
    );
  }
}

class KaryawanPage extends StatefulWidget {
  const KaryawanPage({Key? key}) : super(key: key);

  @override
  State<KaryawanPage> createState() => KaryawanPageState();
}

class KaryawanPageState extends State<KaryawanPage> {
  late TextEditingController textController;
  late List<Karyawan> karyawanList;
  late Stream<List<Map<String, dynamic>>?> noteStream;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    karyawanList = [];
    noteStream = Supabase.instance.client
        .from('karyawan')
        .stream(primaryKey: ['id']).asBroadcastStream();
  }

  Future<void> singOut() async {
    await Supabase.instance.client.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (cotext) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karyawan List'),
        actions: [
          IconButton(
            onPressed: singOut,
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: ListView(
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
          StreamBuilder<List<Map<String, dynamic>>?>(
            stream: noteStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final List<Map<String, dynamic>>? data = snapshot.data;
                if (data != null && data.isNotEmpty) {
                  karyawanList = data.map((e) => Karyawan.fromJson(e)).toList();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: karyawanList.length,
                  itemBuilder: (context, index) {
                    var karyawan = karyawanList[index];
                    return Card(
                      child: ListTile(
                        title: Text(karyawan.nama),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Alamat: ${karyawan.alamat}'),
                            Text(
                                'Divisi: ${karyawan.divisi}'), // Menampilkan divisi di sini
                          ],
                        ),
                        onTap: () => editKaryawan(karyawan),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => editKaryawan(karyawan),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => deleteKaryawan(karyawan),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addKaryawan,
        child: const Icon(Icons.add),
      ),
    );
  }

  void filterSearchResults(String query) {
    // Implement search functionality if needed
  }

  void addKaryawan() {
    showDialog(
      context: context,
      builder: (context) {
        String newNama = '';
        String newAlamat = '';
        String newDivisi = '';

        return AlertDialog(
          title: Text('Add New Karyawan'),
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
                  labelText: 'Divisi',
                ),
                onChanged: (value) {
                  newDivisi = value;
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
                createKaryawan(newNama, newAlamat, newDivisi);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void createKaryawan(String nama, String alamat, String divisi) async {
    final response = await Supabase.instance.client
        .from('karyawan')
        .insert({'nama': nama, 'alamat': alamat, 'divisi': divisi});
    if (response != null && response.error == null) {
      setState(() {
        karyawanList.add(Karyawan(
          id: response.data![0]['id'] as int,
          nama: nama,
          alamat: alamat,
          divisi: divisi,
          profilePictureUrl:
              'https://example.com/default_profile_picture.jpg', // Example URL
        ));
      });
    } else {
      print('Error: ${response.error!.message}');
    }
  }

  void editKaryawan(Karyawan karyawan) {
    showDialog(
      context: context,
      builder: (context) {
        String editedNama = karyawan.nama;
        String editedAlamat = karyawan.alamat;
        String editedDivisi = karyawan.divisi;

        return AlertDialog(
          title: Text('Edit Karyawan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
                controller: TextEditingController(text: karyawan.nama),
                onChanged: (value) {
                  editedNama = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Alamat',
                ),
                controller: TextEditingController(text: karyawan.alamat),
                onChanged: (value) {
                  editedAlamat = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Divisi',
                ),
                controller: TextEditingController(text: karyawan.divisi),
                onChanged: (value) {
                  editedDivisi = value;
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
                updateKaryawan(
                    karyawan.id!, editedNama, editedAlamat, editedDivisi);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void updateKaryawan(int id, String nama, String alamat, String divisi) async {
    final response = await Supabase.instance.client.from('karyawan').update(
        {'nama': nama, 'alamat': alamat, 'divisi': divisi}).eq('id', id);
    if (response.error == null) {
      setState(() {
        var index = karyawanList.indexWhere((karyawan) => karyawan.id == id);
        if (index != -1) {
          karyawanList[index] = Karyawan(
              id: id,
              nama: nama,
              alamat: alamat,
              divisi: divisi,
              profilePictureUrl: karyawanList[index].profilePictureUrl);
        }
      });
    } else {
      print('Error: ${response.error!.message}');
    }
  }

  void deleteKaryawan(Karyawan karyawan) async {
    final response = await Supabase.instance.client
        .from('karyawan')
        .delete()
        .eq('id', karyawan.id as Object);
    if (response.error == null) {
      setState(() {
        karyawanList.removeWhere((element) => element.id == karyawan.id);
      });
    } else {
      print('Error: ${response.error!.message}');
    }
  }
}

class Karyawan {
  final int? id;
  final String nama;
  final String alamat;
  final String divisi;
  final String profilePictureUrl;

  Karyawan({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.divisi,
    required this.profilePictureUrl,
  });

  factory Karyawan.fromJson(Map<String, dynamic> json) => Karyawan(
        id: json['id'] as int?,
        nama: json['nama'] as String,
        alamat: json['alamat'] as String,
        divisi: json['divisi'] as String,
        profilePictureUrl: json['profilePictureUrl'] ?? '',
      );
}
