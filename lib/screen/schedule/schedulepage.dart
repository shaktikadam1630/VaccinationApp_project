import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:vaccination/bloc/schedulebloc/bloc/schedule_bloc.dart';
import 'package:vaccination/model/schedule_model.dart';
import 'package:vaccination/screen/schedule/vaccinationdetailpage.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
    // Fetch schedules when the page is first loaded
    context.read<ScheduleBloc>().add(FetchSchedules());
  }
final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Vaccination Schedule',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<ScheduleBloc, ScheduleState>(
                builder: (context, state) {
                  if (state is ScheduleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ScheduleLoaded) {
                    final List<Map<String, dynamic>> vaccinations = state.schedules;
                    final List<DateTime> dueDates = state.dueDates;

                    return ListView.builder(
                      itemCount: vaccinations.length,
                      itemBuilder: (context, index) {
                        final vaccination = vaccinations[index];
                        final dueDate = dueDates[index];
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

                        return Card(
                          child: ListTile(
                            leading: leadingIcon,
                            title: Text(vaccination['name']),
                            subtitle: Text(
                              vaccination['status'] == 'pending'
                                  ? 'Pending'
                                  : '${vaccination['status'] == 'completed' ? 'Completed on' : 'Scheduled for'} ${dateFormatter.format(dueDate)}',
                            ),
                            onTap: () {
                              // Navigate to the vaccination detail page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VaccinationDetailPage(vaccination: vaccination, dueDate: dueDate,),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is ScheduleError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(child: Text('No schedules available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
