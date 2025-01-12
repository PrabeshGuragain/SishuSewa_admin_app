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
}