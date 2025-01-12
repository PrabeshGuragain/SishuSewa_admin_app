class Child {
  final String id;
  final String name;
  final DateTime dateOfBirth;
  String? parentAppId;
  List<GrowthRecord> growthRecords;
  List<VaccineRecord> vaccineRecords;

  Child({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    this.parentAppId,
    this.growthRecords = const [],
    this.vaccineRecords = const [],
  });
}

class GrowthRecord {
  final DateTime date;
  final double height;
  final double weight;
  final double bmi;

  GrowthRecord({
    required this.date,
    required this.height,
    required this.weight,
    required this.bmi,
  });
}

class VaccineRecord {
  final String vaccineName;
  final DateTime dueDate;
  DateTime? administeredDate;
  String? batchNumber;

  VaccineRecord({
    required this.vaccineName,
    required this.dueDate,
    this.administeredDate,
    this.batchNumber,
  });
}