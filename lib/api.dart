import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:telephony_demo/model_sms.dart';
import 'package:telephony_demo/status_api.dart';

class ApiSms {
  static Future<Object> apiSms(Sms body) async {
    try {
      var response = await http.post(
          Uri.parse('https://hoigg.net/api/save-transaction-payment'),
          headers: {'Content-type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return Success(
            code: 200,
            response: jsonEncode(smsFromJson(jsonEncode(response.body))));
      }
      return False(code: invalidResponse, errresponse: 'Invalid Response');
    } on HttpException {
      return False(code: noInternet, errresponse: 'No internet');
    } on FormatException {
      return False(code: invalidFormat, errresponse: 'Invalid Format');
    } catch (e) {
      return False(code: unknownError, errresponse: 'Unknown Error');
    }
  }
}
