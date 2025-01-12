// lib/providers/inventory_provider.dart
import 'package:flutter/foundation.dart';
import '../models/inventory.dart';  

class InventoryProvider with ChangeNotifier {
  List<VaccineInventory> _inventory = [];

  List<VaccineInventory> get inventory => _inventory;

  Future<void> addVaccineStock(VaccineInventory vaccine) async {
    // TODO: Implement API call to add vaccine stock
    _inventory.add(vaccine);
    notifyListeners();
  }

  Future<void> updateVaccineStock(String vaccineId, int quantity) async {
    // TODO: Implement API call to update vaccine stock
    final vaccineIndex = _inventory.indexWhere((v) => v.vaccineId == vaccineId);
    if (vaccineIndex != -1) {
      _inventory[vaccineIndex].quantity = quantity;
      notifyListeners();
    }
  }
}