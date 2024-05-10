import 'package:contoh/JadwalLibur.dart';
import 'package:contoh/historicutiUser.dart';
import 'package:contoh/sisacutiUser.dart';
import 'package:flutter/material.dart';
import 'Pengajuancuti.dart';
import 'Profile.dart';
import 'main.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cuti Tahunan",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cuti Tahunan"),
        actions: [],
      ),
      body: Container(
        color: Color.fromARGB(
            255, 195, 184, 234), // Ganti dengan warna yang Anda inginkan
        child: !isDrawerOpen
            ? GridView.count(
                crossAxisCount: 2,
                children: [
                  DashboardCard(
                    title: "Jadwal Libur",
                    icon: Icons.calendar_today,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HolidaySchedule(),
                      ));
                    },
                    iconColor: Colors.white,
                    cardColor: Color.fromARGB(255, 157, 137, 221),
                    textColor: Colors.white, // Atur warna latar belakang kartu
                  ),
                  DashboardCard(
                    title: "Form Pengajuan Cuti",
                    icon: Icons.email,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Pengajuancuti(),
                      ));
                    },
                    iconColor: Colors.white, // Atur warna ikon
                    cardColor: Color.fromARGB(255, 157, 137, 221),
                    textColor: Colors.white, // Atur warna latar belakang kartu
                  ),
                  DashboardCard(
                    title: "Histori Cuti Tahunan",
                    icon: Icons.history,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CutiHistoryPage(),
                      ));
                    },
                    iconColor: Colors.white, // Atur warna ikon
                    cardColor: Color.fromARGB(255, 157, 137, 221),
                    textColor: Colors.white, // Atur warna latar belakang kartu
                  ),
                  DashboardCard(
                    title: "Sisa Cuti Tahunan",
                    icon: Icons.beach_access,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SisaCuti(),
                      ));
                    },
                    iconColor: Colors.white, // Atur warna ikon
                    cardColor: Color.fromARGB(255, 157, 137, 221),
                    textColor: Colors.white, // Atur warna latar belakang kartu
                  ),
                ],
              )
            : null,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Anisa Rahmawati"),
              accountEmail: Text("Anisa02@gmail.com"),
              currentAccountPicture: CircleAvatar(
                radius: 30, // Sesuaikan dengan ukuran yang diinginkan
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/free-photo/portrait-beautiful-business-woman-with-glasses-3d-rendering_1142-54789.jpg?t=st=1714092372~exp=1714095972~hmac=169fa2723db58c1b43f1ac56e022a24a62cd053b61ceb6c3612888246ce3f3ce&w=740'), // Ganti dengan URL gambar profil karyawan
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profil Karyawan"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Keluar"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
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
