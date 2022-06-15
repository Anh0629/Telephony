// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telephony/telephony.dart';
import 'package:telephony_demo/controller_sms.dart';
import 'package:telephony_demo/model_sms.dart';
import 'package:telephony_demo/theme.dart';

final Telephony telephony = Telephony.instance;
final SmsController smsController = SmsController();
late final AppLifecycleState state;

backgrounMessageHandler(SmsMessage message) async {
  await smsController.getStringSms(message);
  AppLifecycleState state = AppLifecycleState.resumed;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (BuildContext context, Widget? child) {
          return const MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: MyHomePage(title: 'Flutter Demo Telephony'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<SmsMessage> _list = [];
  final SmsController smsController = SmsController();
  final Telephony telephony = Telephony.instance;
  SmsMessage? message;

  void getInbox() {
    telephony.getInboxSms(columns: [
      SmsColumn.ADDRESS,
      SmsColumn.BODY
    ], filter: SmsFilter.where(SmsColumn.ADDRESS).equals('Techcombank')).then(
        (value) => setState(() => _list = value));
    print('getInbox +ADDRESS : ${SmsColumn.ADDRESS}');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print(
          'get inbox owr didChangeAppLifecycleState--------------------------------- ');
      getInbox();
    }
    if (state == AppLifecycleState.paused) {
      final Telephony telephony = Telephony.instance;
      telephony.listenIncomingSms(
          onNewMessage: ((SmsMessage message) async {
            print(message.body);
            getInbox();
            await smsController.getStringSms(message);
          }),
          onBackgroundMessage: backgrounMessageHandler);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late Sms data;

  @override
  void initState() {
    super.initState();

    getInbox();

    WidgetsBinding.instance.addObserver(this);

    telephony.listenIncomingSms(
        listenInBackground: false,
        onNewMessage: (SmsMessage _message) async {
          setState(() {
            message = _message;
          });
          getInbox();
          await smsController.getStringSms(_message);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1.h,
        width: MediaQuery.of(context).size.width * 1.w,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage(
                "assets/image/giphy.gif",
              ),
              fit: BoxFit.cover,
              opacity: 0.5),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int i) {
                final item = _list[i];

                return Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.address ?? "",
                          style: textHeader.titleMedium,
                        ),
                        Text(item.body ?? "", style: textdata.bodyText1),
                        const Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                      ]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
