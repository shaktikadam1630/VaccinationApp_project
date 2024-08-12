import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'vaccineName': 'Hepatitis B',
      'date': DateTime.now().subtract(Duration(days: 1)),
      'status': 'pending'
    },
    {
      'id': 2,
      'vaccineName': 'Polio',
      'date': DateTime.now().add(Duration(days: 3)),
      'status': 'upcoming'
    },
    {
      'id': 3,
      'vaccineName': 'MMR',
      'date': DateTime.now().add(Duration(days: 10)),
      'status': 'upcoming'
    },
  ];

  @override
  void initState() {
    super.initState();
    filterNotifications();
  }

  void filterNotifications() {
    final currentDate = DateTime.now();
    setState(() {
      notifications = notifications.where((notification) {
        final dueDate = notification['date'];
        final difference = dueDate.difference(currentDate).inDays;
        return difference <= 2 && difference >= -2; // Filter for 2 days before and after
      }).toList();
    });
  }

  void updateVaccinationStatus(int id) {
    setState(() {
      notifications = notifications.map((notification) {
        if (notification['id'] == id) {
          notification['status'] = 'completed';
        }
        return notification;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final dueDate = notification['date'];
          final status = notification['status'];
          final vaccineName = notification['vaccineName'];

          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Text(
                vaccineName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Due Date: ${DateFormat('dd/MM/yyyy').format(dueDate)}'),
                  SizedBox(height: 5),
                  Text(
                    'Status: $status',
                    style: TextStyle(
                      color: status == 'completed' ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: status == 'completed'
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : ElevatedButton(
                      onPressed: () {
                        updateVaccinationStatus(notification['id']);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('OK'),
                    ),
            ),
          );
        },
      ),
    );
  }
}
