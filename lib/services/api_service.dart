// lib/services/api_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/child.dart';
import '../models/vaccine_inventory.dart';

class ApiService {
  // Keys for SharedPreferences
  static const String _childrenKey = 'children_data';
  static const String _inventoryKey = 'inventory_data';

  // Get the SharedPreferences instance
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  // Child-related operations
  Future<Child> addChild(Child child) async {
    try {
      final prefs = await _prefs;
      List<String> childrenJson = prefs.getStringList(_childrenKey) ?? [];
      
      // Convert the new child to JSON and add to the list
      childrenJson.add(jsonEncode(child.toJson()));
      
      // Save the updated list
      await prefs.setStringList(_childrenKey, childrenJson);
      
      return child;
    } catch (e) {
      throw Exception('Failed to add child: $e');
    }
  }

  Future<void> updateGrowthRecord(String childId, GrowthRecord record) async {
    try {
      final prefs = await _prefs;
      List<String> childrenJson = prefs.getStringList(_childrenKey) ?? [];
      
      // Find and update the child's growth records
      List<Map<String, dynamic>> children = childrenJson
          .map((str) => jsonDecode(str) as Map<String, dynamic>)
          .toList();
          
      final childIndex = children.indexWhere((c) => c['id'] == childId);
      if (childIndex != -1) {
        children[childIndex]['growthRecords'].add(record.toJson());
        childrenJson = children.map((c) => jsonEncode(c)).toList();
        await prefs.setStringList(_childrenKey, childrenJson);
      }
    } catch (e) {
      throw Exception('Failed to update growth record: $e');
    }
  }

  Future<void> updateVaccineRecord(String childId, VaccineRecord record) async {
    try {
      final prefs = await _prefs;
      List<String> childrenJson = prefs.getStringList(_childrenKey) ?? [];
      
      List<Map<String, dynamic>> children = childrenJson
          .map((str) => jsonDecode(str) as Map<String, dynamic>)
          .toList();
          
      final childIndex = children.indexWhere((c) => c['id'] == childId);
      if (childIndex != -1) {
        children[childIndex]['vaccineRecords'].add(record.toJson());
        childrenJson = children.map((c) => jsonEncode(c)).toList();
        await prefs.setStringList(_childrenKey, childrenJson);
      }
    } catch (e) {
      throw Exception('Failed to update vaccine record: $e');
    }
  }

  Future<void> linkParentApp(String childId, String parentAppId) async {
    try {
      final prefs = await _prefs;
      List<String> childrenJson = prefs.getStringList(_childrenKey) ?? [];
      
      List<Map<String, dynamic>> children = childrenJson
          .map((str) => jsonDecode(str) as Map<String, dynamic>)
          .toList();
          
      final childIndex = children.indexWhere((c) => c['id'] == childId);
      if (childIndex != -1) {
        children[childIndex]['parentAppId'] = parentAppId;
        childrenJson = children.map((c) => jsonEncode(c)).toList();
        await prefs.setStringList(_childrenKey, childrenJson);
      }
    } catch (e) {
      throw Exception('Failed to link parent app: $e');
    }
  }

  // Inventory-related operations
  Future<VaccineInventory> addVaccineStock(VaccineInventory vaccine) async {
    try {
      final prefs = await _prefs;
      List<String> inventoryJson = prefs.getStringList(_inventoryKey) ?? [];
      
      inventoryJson.add(jsonEncode(vaccine.toJson()));
      await prefs.setStringList(_inventoryKey, inventoryJson);
      
      return vaccine;
    } catch (e) {
      throw Exception('Failed to add vaccine stock: $e');
    }
  }

  Future<void> updateVaccineStock(String vaccineId, int quantity) async {
    try {
      final prefs = await _prefs;
      List<String> inventoryJson = prefs.getStringList(_inventoryKey) ?? [];
      
      List<Map<String, dynamic>> inventory = inventoryJson
          .map((str) => jsonDecode(str) as Map<String, dynamic>)
          .toList();
          
      final vaccineIndex = inventory.indexWhere((v) => v['vaccineId'] == vaccineId);
      if (vaccineIndex != -1) {
        inventory[vaccineIndex]['quantity'] = quantity;
        inventoryJson = inventory.map((v) => jsonEncode(v)).toList();
        await prefs.setStringList(_inventoryKey, inventoryJson);
      }
    } catch (e) {
      throw Exception('Failed to update vaccine stock: $e');
    }
  }

  // Helper methods to get all data
  Future<List<Child>> getAllChildren() async {
    final prefs = await _prefs;
    List<String> childrenJson = prefs.getStringList(_childrenKey) ?? [];
    return childrenJson
        .map((str) => Child.fromJson(jsonDecode(str)))
        .toList();
  }

  Future<List<VaccineInventory>> getAllInventory() async {
    final prefs = await _prefs;
    List<String> inventoryJson = prefs.getStringList(_inventoryKey) ?? [];
    return inventoryJson
        .map((str) => VaccineInventory.fromJson(jsonDecode(str)))
        .toList();
  }
}