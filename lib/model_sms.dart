// To parse this JSON data, do
//
//     final sms = smsFromJson(jsonString);

import 'dart:convert';

Sms smsFromJson(String str) => Sms.fromJson(json.decode(str));

String smsToJson(Sms data) => json.encode(data.toJson());

class Sms {
  Sms({
    this.pMoney,
    this.pNote,
  });

  int? pMoney;
  String? pNote;

  factory Sms.fromJson(Map<String, dynamic> json) => Sms(
        pMoney: json["p_money"],
        pNote: json["p_note"],
      );

  Map<String, dynamic> toJson() => {
        "p_money": pMoney,
        "p_note": pNote,
      };
}
