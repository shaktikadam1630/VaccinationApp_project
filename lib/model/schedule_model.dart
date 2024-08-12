class Vaccination {
  final String? name;
  final String? ageInWeeks;
  final String? status;
  
  Vaccination({
    required this.name,
    required this.ageInWeeks,
    required this.status,
  });

  factory Vaccination.fromMap(Map<String, dynamic> data) {
    return Vaccination(
      name: data['name'],
      ageInWeeks: data['ageInWeeks'],
      status: data['status'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ageInWeeks': ageInWeeks,
      'status': status,
    };
  }

  Vaccination copyWith({
    String? name,
    String? ageInWeeks,
    String? status,
  }) {
    return Vaccination(
      name: name ?? this.name,
      ageInWeeks: ageInWeeks ?? this.ageInWeeks,
      status: status ?? this.status,
    );
  }
}
