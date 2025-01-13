import 'package:flutter/material.dart';
import 'package:admin_app/models/child.dart';


// lib/providers/children_provider.dart
class ChildrenProvider with ChangeNotifier {
  final List<Child> _children = [];

  List<Child> get children => _children;

  Future<void> addChild(Child child) async {
    // TODO: Implement API call to add child
    _children.add(child);
    notifyListeners();
  }

  Future<void> updateGrowthRecord(String childId, GrowthRecord record) async {
    // TODO: Implement API call to update growth record
    final childIndex = _children.indexWhere((c) => c.id == childId);
    if (childIndex != -1) {
      _children[childIndex].growthRecords.add(record);
      notifyListeners();
    }
  }

  Future<void> updateVaccineRecord(String childId, VaccineRecord record) async {
    // TODO: Implement API call to update vaccine record
    final childIndex = _children.indexWhere((c) => c.id == childId);
    if (childIndex != -1) {
      _children[childIndex].vaccineRecords.add(record);
      notifyListeners();
    }
  }

  Future<void> linkParentApp(String childId, String parentAppId) async {
    // TODO: Implement API call to link parent app
    final childIndex = _children.indexWhere((c) => c.id == childId);
    if (childIndex != -1) {
      _children[childIndex].parentAppId = parentAppId;
      notifyListeners();
    }
  }
}