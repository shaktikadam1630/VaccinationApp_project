part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<Map<String, dynamic>> schedules;
  final List<DateTime> dueDates;
   ScheduleLoaded(this.schedules, this.dueDates);
}

  
class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError(this.message);
}
