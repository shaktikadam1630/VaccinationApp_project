import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:vaccination/bloc/schedulebloc/bloc/schedule_bloc.dart';
import 'package:vaccination/model/schedule_model.dart';
import 'package:vaccination/screen/googlemap/googlemap_screen.dart';
import 'package:vaccination/screen/profile/profilepage.dart';
import 'package:vaccination/screen/schedule/schedulepage.dart';
import 'package:vaccination/screen/schedule/vaccinationdetailpage.dart';
import 'package:vaccination/services/get_server_key.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch schedules when the page is first loaded
    context.read<ScheduleBloc>().add(FetchSchedules());
  }

  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IconButton(
              iconSize: 200,
              icon: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/profiles.jpg'),
                backgroundColor: Colors.purple,
              ),
              onPressed: () async {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => GoogleMapScreen(),
                //   ),
                // );
                // GetServerKey getServerKey = GetServerKey();
                // String accesstoken = await getServerKey.getServerKeyToken();
                // print('serverkey $accesstoken');
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ScheduleError) {
            print(state.message);
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ScheduleLoaded) {
            final List<Map<String, dynamic>> vaccinations = state.schedules;
            final List<DateTime> dueDates = state.dueDates;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Welcome to Vaccination App!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/vaccination.jpg',
                    width: size.width * 0.97,
                    height: size.height * 0.25,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Completed/Pending Vaccinations',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: vaccinations.length,
                      itemBuilder: (context, index) {
                        final vaccination = vaccinations[index];
                        final dueDate = dueDates[index];

                        if (vaccination['status'] == 'completed' ||
                            vaccination['status'] == 'pending') {
                          return Card(
                            child: ListTile(
                              leading: Icon(
                                vaccination['status'] == 'completed'
                                    ? Icons.check_circle
                                    : Icons.pending,
                                color: vaccination['status'] == 'completed'
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                              title: Text(vaccination['name']),
                              subtitle: Text(dateFormatter.format(dueDate)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VaccinationDetailPage(
                                      vaccination: vaccination,
                                      dueDate: dueDate,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Upcoming Vaccinations',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: vaccinations.length,
                      itemBuilder: (context, index) {
                        final vaccination = vaccinations[index];
                        final dueDate = dueDates[index];

                        if (vaccination['status'] == 'upcoming') {
                          return Card(
                            child: ListTile(
                              leading: Icon(Icons.event, color: Colors.blue),
                              title: Text(vaccination['name']),
                              subtitle: Text(
                                  'Scheduled for ${dateFormatter.format(dueDate)}'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VaccinationDetailPage(
                                      vaccination: vaccination,
                                      dueDate: dueDate,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Welcome to Vaccination App!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/vaccination.jpg',
                    width: size.width * 0.97,
                    height: size.height * 0.25,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Completed/Pending Vaccinations',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Center(child: Text('No data found')),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Upcoming Vaccinations',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Center(child: Text('No data found')),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
