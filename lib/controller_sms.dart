// ignore_for_file: avoid_print

import 'package:telephony/telephony.dart';
import 'package:telephony_demo/api.dart';
import 'package:telephony_demo/model_sms.dart';
import 'package:telephony_demo/status_api.dart';

class SmsController {
  final Sms sms = Sms();

  getStringSms(SmsMessage smsMessage) async {
    final regex1 = RegExp(r'[0-9]+\,[0-9]+');
    final regex2 = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    final match1 = regex1.firstMatch(smsMessage.body!);
    final match2 = match1!.group(0);
    int money = int.parse(match2!.replaceAll(',', ''));
    var index = smsMessage.body!.lastIndexOf(regex2);
    final SmsController smsController = SmsController();
    final match4 = smsMessage.body!.trim().split('.');
    String data4 = '';
    print(match4.length);
    for (int i = 3; i < match4.length; i++) {
      data4 = data4 + match4[i];
    }
    Sms data;
    if (RegExp("\\b(TK)\\b").hasMatch(smsMessage.body!)) {
      data = Sms(pMoney: money, pNote: data4);
      await smsController.getDataSms(data);
    }
  }

  getDataSms(Sms data) async {
    var response = await ApiSms.apiSms(data);
    if (response is Success) {
      return response = response.response as Sms;
    }
    if (response is False) {
      Error err = Error(code: response.code, message: response.errresponse);
      return err;
    }
  }
}
