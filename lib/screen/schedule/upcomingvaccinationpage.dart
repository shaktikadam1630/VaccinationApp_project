import 'package:flutter/material.dart';
import 'package:vaccination/screen/schedule/vaccinationdetailpage.dart';


class UpcomingVaccinationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> upcomingVaccinations;

  const UpcomingVaccinationsPage({Key? key, required this.upcomingVaccinations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Vaccinations'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: upcomingVaccinations.length,
        itemBuilder: (context, index) {
          final vaccination = upcomingVaccinations[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.event, color: Colors.blue),
              title: Text(vaccination['name']),
              subtitle: Text('Scheduled for ${vaccination['date']}'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => VaccinationDetailPage(vaccination: vaccination, dueDate: ,),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
