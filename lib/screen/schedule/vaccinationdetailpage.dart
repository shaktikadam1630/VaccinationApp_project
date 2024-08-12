import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VaccinationDetailPage extends StatelessWidget {
  final Map<String, dynamic> vaccination;
   final DateTime dueDate;
 VaccinationDetailPage({Key? key, required this.vaccination,required this.dueDate}) : super(key: key);
final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    Icon leadingIcon;
    switch (vaccination['status']) {
      case 'completed':
        leadingIcon = const Icon(Icons.check_circle, color: Colors.green);
        break;
      case 'pending':
        leadingIcon = const Icon(Icons.pending, color: Colors.orange);
        break;
      case 'upcoming':
        leadingIcon = const Icon(Icons.event, color: Colors.blue);
        break;
      default:
        leadingIcon = const Icon(Icons.help_outline);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccination Detail'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                leadingIcon,
                const SizedBox(width: 10),
                Text(
                  vaccination['name'],
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Status: ${vaccination['status'].toUpperCase()}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
  vaccination['status'] == 'pending'
      ? 'Pending'
      : vaccination['status'] == 'completed'
          ? 'Completed on ${dateFormatter.format(dueDate)}'
          : 'Scheduled for ${dateFormatter.format(dueDate)}',
  style: const TextStyle(fontSize: 18),
),

            const SizedBox(height: 20),
            const Text(
              'Additional Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              vaccination['Additional Information'] ?? 'No additional information available.',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
