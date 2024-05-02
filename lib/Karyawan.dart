import 'package:contoh/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  late List<Map<String, dynamic>> noteStream;

  @override
  void initState() async {
    super.initState();
    textController = TextEditingController();
    karyawanList = [];
    noteStream = await Supabase.instance.client.from('karyawan').select();
  }

  Future<void> singOut() async {
    await Supabase.instance.client.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (cotext) => const LoginPage()));
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
            stream: ffgd,
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
                  itemCount: karyawanList.length,
                  itemBuilder: (context, index) {
                    var karyawan = karyawanList[index];
                    return ListTile(
                      title: Text(karyawan.nama),
                      subtitle: Text(karyawan.alamat),
                      onTap: () => editKaryawan(karyawan),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteKaryawan(karyawan),
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
        child: Icon(Icons.add),
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
    if (response.error == null) {
      // If successful, add to local list
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
      // If successful, update local list
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
      // If failed, display error message
      print('Error: ${response.error!.message}');
    }
  }

  void deleteKaryawan(Karyawan karyawan) async {
    final response = await Supabase.instance.client
        .from('karyawan')
        .delete()
        .eq('id', karyawan.id as Object);
    if (response.error == null) {
      // If successful, remove from local list
      setState(() {
        karyawanList.removeWhere((element) => element.id == karyawan.id);
      });
    } else {
      // If failed, display error message
      print('Error: ${response.error!.message}');
    }
  }
}

class Karyawan {
  final int? id;
  final String nama;
  final String alamat;
  final String divisi;
  final String profilePictureUrl; // New field for profile picture URL

  Karyawan({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.divisi,
    required this.profilePictureUrl, // Updated constructor
  });

  factory Karyawan.fromJson(Map<String, dynamic> json) => Karyawan(
        id: json['id'] as int?,
        nama: json['nama'] as String,
        alamat: json['alamat'] as String,
        divisi: json['divisi'] as String,
        profilePictureUrl:
            json['profilePictureUrl'] ?? '', // Use null-ish coalescing operator
      );
}
