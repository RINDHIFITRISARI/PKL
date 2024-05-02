import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    "https://img.freepik.com/free-photo/portrait-beautiful-business-woman-with-glasses-3d-rendering_1142-54789.jpg?t=st=1714092372~exp=1714095972~hmac=169fa2723db58c1b43f1ac56e022a24a62cd053b61ceb6c3612888246ce3f3ce&w=740"),
              ),
              const SizedBox(height: 20),
              itemProfile('NIK', '33250824560002', Icons.credit_card,
                  color: Colors.white),
              const SizedBox(height: 10),
              itemProfile('Nama', 'Anisa Rahmawati', Icons.person,
                  color: Colors.white),
              const SizedBox(height: 10),
              itemProfile('Divisi', 'Data Analyst', Icons.work,
                  color: Colors.white),
              const SizedBox(height: 10),
              itemProfile('Pendidikan', 'S1 Teknik Informatika', Icons.school,
                  color: Colors.white),
              const SizedBox(height: 10),
              itemProfile('Tephone', '082325620683', Icons.phone,
                  color: Colors.white),
              const SizedBox(height: 10),
              itemProfile('Alamat', 'Jl. Krakatau No. 08', Icons.location_on,
                  color: Colors.white),
              const SizedBox(height: 10),
              itemProfile('Email', 'Anisa02@gmail.com', Icons.mail,
                  color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData,
      {Color color = Colors.white}) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 157, 137, 221),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Color.fromARGB(255, 228, 227, 232),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.white)),
        leading: Icon(iconData, color: Colors.white),
        tileColor: Colors.white,
      ),
    );
  }
}
