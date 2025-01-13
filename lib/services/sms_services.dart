// lib/services/sms_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class SmsService {
  static const String _apiUrl = 'YOUR_SMS_API_ENDPOINT';
  static const String _apiKey = 'YOUR_SMS_API_KEY';

  Future<bool> sendVaccineReminder({
    required String phone,
    required String childName,
    required String vaccineName,
    required DateTime dueDate,
  }) async {
    try {
      final message = 'Dear Parent, your child $childName is due for $vaccineName '
          'vaccination on ${dueDate.toString().split(' ')[0]}. Please visit your '
          'nearest health center. -Health Worker Portal';

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone': phone,
          'message': message,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Failed to send SMS: $e');
      return false;
    }
  }
}
