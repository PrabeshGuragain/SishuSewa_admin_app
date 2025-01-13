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

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'parentAppId': parentAppId,
      'growthRecords': growthRecords.map((record) => record.toJson()).toList(),
      'vaccineRecords': vaccineRecords.map((record) => record.toJson()).toList(),
    };
  }

  // Add fromJson factory constructor
  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      name: json['name'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      parentAppId: json['parentAppId'],
      growthRecords: (json['growthRecords'] as List)
          .map((record) => GrowthRecord.fromJson(record))
          .toList(),
      vaccineRecords: (json['vaccineRecords'] as List)
          .map((record) => VaccineRecord.fromJson(record))
          .toList(),
    );
  }
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

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'height': height,
      'weight': weight,
      'bmi': bmi,
    };
  }

  // Add fromJson factory constructor
  factory GrowthRecord.fromJson(Map<String, dynamic> json) {
    return GrowthRecord(
      date: DateTime.parse(json['date']),
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      bmi: json['bmi'].toDouble(),
    );
  }
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

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'vaccineName': vaccineName,
      'dueDate': dueDate.toIso8601String(),
      'administeredDate': administeredDate?.toIso8601String(),
      'batchNumber': batchNumber,
    };
  }

  // Add fromJson factory constructor
  factory VaccineRecord.fromJson(Map<String, dynamic> json) {
    return VaccineRecord(
      vaccineName: json['vaccineName'],
      dueDate: DateTime.parse(json['dueDate']),
      administeredDate: json['administeredDate'] != null 
          ? DateTime.parse(json['administeredDate']) 
          : null,
      batchNumber: json['batchNumber'],
    );
  }
} 