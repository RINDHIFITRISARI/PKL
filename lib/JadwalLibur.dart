import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HolidaySchedule()),
            );
          },
          child: Text('Jadwal Libur'),
        ),
      ),
    );
  }
}

class HolidaySchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<HolidayItem> holidayItems = _generateHolidayItems();
    holidayItems.sort((a, b) => a.date.compareTo(b.date));

    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Libur Tahun 2024'),
      ),
      body: ListView.builder(
        itemCount: holidayItems.length,
        itemBuilder: (context, index) {
          return holidayItems[index];
        },
      ),
    );
  }
}

List<HolidayItem> _generateHolidayItems() {
  List<HolidayItem> items = [];

  for (int month = 1; month <= 12; month++) {
    for (int day = 1; day <= 31; day++) {
      DateTime date = DateTime(2024, month, day);
      if (date.month == month &&
          (date.weekday == DateTime.saturday ||
              date.weekday == DateTime.sunday)) {
        items.add(HolidayItem(
          title: 'Hari Libur 2024',
          date: date,
        ));
      }
    }
  }

  List<String> nationalHolidays = [
    'Tahun Baru 2024 - 2024-01-01',
    'Imlek 2575 - 2024-02-01',
    'Hari Raya Nyepi - 2024-03-21',
    'Jumat Agung - 2024-03-29',
    'Paskah - 2024-03-31',
    'Hari Buruh Internasional - 2024-05-01',
    'Kenaikan Isa Almasih - 2024-05-09',
    'Hari Raya Waisak - 2024-05-20',
    'Hari Lahir Pancasila - 2024-06-01',
    'Hari Raya Idul Fitri 1445 H - 2024-06-07',
    'Hari Raya Idul Fitri 1445 H - 2024-06-08',
    'Hari Raya Idul Adha 1445 H - 2024-07-14',
    'Hari Kemerdekaan Republik Indonesia - 2024-08-17',
    'Tahun Baru Islam 1446 H - 2024-08-31',
    'Maulid Nabi Muhammad SAW - 2024-10-24',
    'Hari Raya Natal - 2024-12-25',
  ];

  for (String holiday in nationalHolidays) {
    List<String> parts = holiday.split(' - ');
    String title = parts[0];
    DateTime date = DateTime.parse(parts[1]);
    items.add(HolidayItem(title: title, date: date));
  }

  return items;
}

class HolidayItem extends StatelessWidget {
  final String title;
  final DateTime date;

  const HolidayItem({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(_formattedDate(date)),
          Divider(),
        ],
      ),
    );
  }

  String _formattedDate(DateTime date) {
    return '${_getDayOfWeek(date.weekday)}, ${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Senin';
      case DateTime.tuesday:
        return 'Selasa';
      case DateTime.wednesday:
        return 'Rabu';
      case DateTime.thursday:
        return 'Kamis';
      case DateTime.friday:
        return 'Jumat';
      case DateTime.saturday:
        return 'Sabtu';
      case DateTime.sunday:
        return 'Minggu';
      default:
        return '';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }
}
