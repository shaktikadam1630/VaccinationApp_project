import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:vaccination/model/schedule_model.dart';
import 'package:vaccination/model/user_model.dart';
import 'package:vaccination/services/getuser.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitial()) {
    on<FetchSchedules>(_onFetchSchedules);
  }

  Future<void> _onFetchSchedules(
      FetchSchedules event, Emitter<ScheduleState> emit) async {
    emit(ScheduleLoading());
    try {
      // Fetch the child's birth date
      final birthDate = ActiveUser.currentuser.birthdate;
      if (birthDate == null) {
        throw Exception('Birth date not found');
      }

      print("Birthdate: $birthDate");

      // Fetch the vaccination schedule
      final vaccinationSnapshot =
          await FirebaseFirestore.instance.collection('Scheduled').get();
      final vaccinations = vaccinationSnapshot.docs
          .map((doc) => Vaccination.fromMap(doc.data()))
          .toList();

      // Calculate vaccination dates and update statuses based on the birth date
      final List<DateTime> dueDates = [];
      final updatedVaccinations = vaccinations.map((vaccination) {
        final ageInWeeks = int.parse(vaccination.ageInWeeks!);
        final dueDate = calculateVaccinationDate(birthDate, ageInWeeks);
        dueDates.add(dueDate);
        final status = determineStatus(dueDate);
        return vaccination.copyWith(
          status: status,
        );
      }).toList();

      emit(ScheduleLoaded(
          updatedVaccinations.map((vaccination) => vaccination.toMap()).toList(),
          dueDates));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  DateTime calculateVaccinationDate(DateTime birthDate, int ageInWeeks) {
    return birthDate.add(Duration(days: ageInWeeks * 7)); // Convert weeks to days
  }

  String determineStatus(DateTime dueDate) {
    final now = DateTime.now();
    if (dueDate.isBefore(now)) {
      return 'completed';
    } else if (dueDate.isAfter(now)) {
      return 'upcoming';
    } else {
      return 'pending';
    }
  }
}
