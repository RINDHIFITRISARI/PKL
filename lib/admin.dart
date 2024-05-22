import 'package:contoh/HistoryCuti.dart';
import 'package:contoh/Karyawan.dart';
import 'package:contoh/main.dart';
import 'package:contoh/sisacuti.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cuti Tahunan",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cuti Tahunan"),
        actions: [],
      ),
      body: Container(
        color: Color.fromARGB(255, 195, 184, 234),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            DashboardCard(
              title: "Data Karyawan",
              icon: Icons.people,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const KaryawanPage(),
                ));
              },
              iconColor: Colors.white,
              cardColor: Color.fromARGB(255, 157, 137, 221),
              textColor: Colors.white,
            ),
            DashboardCard(
              title: "Histori Cuti Tahunan",
              icon: Icons.history,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HistoryCuti(),
                ));
              },
              iconColor: Colors.white,
              cardColor: Color.fromARGB(255, 157, 137, 221),
              textColor: Colors.white,
            ),
            DashboardCard(
              title: "Sisa Cuti Tahunan",
              icon: Icons.view_compact_alt_outlined,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SisaCutiPage(),
                ));
              },
              iconColor: Colors.white,
              cardColor: Color.fromARGB(255, 157, 137, 221),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Admin"),
              accountEmail: Text("Admin02@gmail.com"),
              currentAccountPicture: CircleAvatar(
                radius: 30, // Sesuaikan dengan ukuran yang diinginkan
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/free-photo/businessman-with-laptop-grey-background-3d-illustration-cartoon-character_1142-39015.jpg?t=st=1714091572~exp=1714095172~hmac=32e519ad5b628c61c483d7f07c6cdf1971391bb45823b10174a2a791bbfd0e14&w=740'), // Ganti dengan URL gambar profil karyawan
              ),
            ),
            // ListTile(
            //   leading: const Icon(Icons.person),
            //   title: const Text("Profil Karyawan"),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => const ProfileScreen(),
            //     ));
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Keluar"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color cardColor;
  final Color textColor;

  const DashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.blue,
    this.cardColor = Colors.white,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: iconColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
