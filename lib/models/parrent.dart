// lib/models/parent.dart
import 'package:admin_app/models/child.dart';

class Parent {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String email;

  Parent({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'address': address,
    'email': email,
  };

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    address: json['address'],
    email: json['email'],
  );
}

// lib/models/vaccine_schedule.dart
class VaccineSchedule {
  final String id;
  final String name;
  final int ageInMonths;
  final String description;
  final bool isRequired;

  VaccineSchedule({
    required this.id,
    required this.name,
    required this.ageInMonths,
    required this.description,
    required this.isRequired,
  });

  static List<VaccineSchedule> get nepalSchedule => [
    VaccineSchedule(
      id: 'bcg',
      name: 'BCG',
      ageInMonths: 0,
      description: 'Bacillus Calmette–Guérin vaccine',
      isRequired: true,
    ),
    VaccineSchedule(
      id: 'opv0',
      name: 'OPV 0',
      ageInMonths: 0,
      description: 'Oral Polio Vaccine at birth',
      isRequired: true,
    ),
    VaccineSchedule(
      id: 'opv1',
      name: 'OPV 1',
      ageInMonths: 1,
      description: 'Oral Polio Vaccine first dose',
      isRequired: true,
    ),
    VaccineSchedule(
      id: 'penta1',
      name: 'Penta 1',
      ageInMonths: 1,
      description: 'DPT-HepB-Hib first dose',
      isRequired: true,
    ),
    VaccineSchedule(
      id: 'pcv1',
      name: 'PCV 1',
      ageInMonths: 1,
      description: 'Pneumococcal Conjugate Vaccine first dose',
      isRequired: true,
    ),
    // Add more vaccines according to Nepal's schedule
  ];
}

// Update Child model to include parent
class Child {
  final String id;
  final String name;
  final DateTime dateOfBirth;
  String? parentAppId;
  Parent? parent;
  List<GrowthRecord> growthRecords;
  List<VaccineRecord> vaccineRecords;

  Child({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    this.parentAppId,
    this.parent,
    this.growthRecords = const [],
    this.vaccineRecords = const [],
  });

  // Update toJson and fromJson methods
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'parentAppId': parentAppId,
    'parent': parent?.toJson(),
    'growthRecords': growthRecords.map((record) => record.toJson()).toList(),
    'vaccineRecords': vaccineRecords.map((record) => record.toJson()).toList(),
  };

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json['id'],
    name: json['name'],
    dateOfBirth: DateTime.parse(json['dateOfBirth']),
    parentAppId: json['parentAppId'],
    parent: json['parent'] != null ? Parent.fromJson(json['parent']) : null,
    growthRecords: (json['growthRecords'] as List)
        .map((record) => GrowthRecord.fromJson(record))
        .toList(),
    vaccineRecords: (json['vaccineRecords'] as List)
        .map((record) => VaccineRecord.fromJson(record))
        .toList(),
  );
}