class VaccineInventory {
  final String vaccineId;
  final String name;
  int quantity;
  final DateTime expiryDate;
  final String batchNumber;

  VaccineInventory({
    required this.vaccineId,
    required this.name,
    required this.quantity,
    required this.expiryDate,
    required this.batchNumber,
  });

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'vaccineId': vaccineId,
      'name': name,
      'quantity': quantity,
      'expiryDate': expiryDate.toIso8601String(),
      'batchNumber': batchNumber,
    };
  }

  // Add fromJson factory constructor
  factory VaccineInventory.fromJson(Map<String, dynamic> json) {
    return VaccineInventory(
      vaccineId: json['vaccineId'],
      name: json['name'],
      quantity: json['quantity'],
      expiryDate: DateTime.parse(json['expiryDate']),
      batchNumber: json['batchNumber'],
    );
  }
}